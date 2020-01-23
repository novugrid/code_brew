import 'package:code_brew/src/bloc/BaseBloc.dart';
import 'package:code_brew/src/models/BaseModel.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/BaseBloc.dart';


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

  @override
  void initState() {
    baseBloc = BaseBloc(widget.model);
    baseBloc.add(BlocEvent.fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocModel>(
      stream: baseBloc.outBlocModel,
      // ignore: missing_return
        builder: (context, AsyncSnapshot<BlocModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                      child: CircularProgressIndicator(),
                    );
            case ConnectionState.active:
            case ConnectionState.done:

              return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: getItemCount(snapshot.data.data), // todoModel.todoList.length,
                        itemBuilder: (context, index) {
                          return widget.itemBuilder(context, index, snapshot.data.data); // _buildItem(todoModel.todoList[index]);
                        }
                    );
          }
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

  @override
  void dispose() {
    baseBloc.dispose();
    super.dispose();
  }

}