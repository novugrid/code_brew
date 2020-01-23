import 'package:code_brew/src/bloc/BaseBloc.dart';
import 'package:code_brew/src/models/BaseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


///A wonder ful
/// project: test_stuff
/// @package: ui
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-11
class UIListView<T> extends StatefulWidget {

  Widget Function(BuildContext context, int index, dynamic data ) itemBuilder;
  BaseModel model;

  UIListView({@required this.itemBuilder, @required this.model});

  @override
  State<StatefulWidget> createState() {
    return _UIListViewState<T>();
  }

}

class _UIListViewState<T> extends State<UIListView> {

  BaseBloc baseBloc;
  // T todoModel;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
//    baseBloc = BlocProvider.of<BaseBloc>(context);
//    baseBloc.modellable = widget.model; // TodoModel();
//    baseBloc.add(BaseEvent.loadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(
      // ignore: missing_return
        builder: (context, state) {
          return state.when(
              initial: (_) =>
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              loading: (_) =>
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              loaded: (state) {
                print("data is back");
                print(state.data);
                if(state.data is T) {
                  // todoModel = state.todo;
                  return SmartRefresher(controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context,LoadStatus mode){
                        Widget body ;
                        if(mode==LoadStatus.idle){
                          body =  Text("pull up load");
                        }
                        else if(mode==LoadStatus.loading){
                          body =  CupertinoActivityIndicator();
                        }
                        else if(mode == LoadStatus.failed){
                          body = Text("Load Failed!Click retry!");
                        }
                        else if(mode == LoadStatus.canLoading){
                          body = Text("release to load more");
                        }
                        else{
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child:body),
                        );
                      },
                    ),
                    onRefresh: () => baseBloc.add(BaseEvent.refresh()),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: getItemCount(state.data), // todoModel.todoList.length,
                        itemBuilder: (context, index) {
                          return widget.itemBuilder(context, index, state.data); // _buildItem(todoModel.todoList[index]);
                        }
                    ),
                  );
                } else {
                  return Text("cant identify this model");
                }
              },
              error: (e) => Text("Error ${e.message}"),
              dataRefreshed: (DataRefreshed ) {

              }
          );
        }
    );
  }

  int getItemCount(BaseModel model) {

    if (model.data is List) {
      return model.data.length;
    }
//    if (data is Map)
    return 0;
  }

}