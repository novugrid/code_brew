import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/bloc/BaseBloc.dart';
import 'package:code_brew/src/models/BaseModel.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/ui/list/smart_refresher/indicator/classic_indicator.dart';
import 'package:code_brew/src/ui/list/smart_refresher/indicator/material_indicator.dart';
import 'package:code_brew/src/ui/list/smart_refresher/smart_refresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/BaseBloc.dart';

///A wonder ful
/// project: test_stuff
/// @package: ui
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-11
class UIListView<T> extends StatefulWidget {
  Widget Function(BuildContext context, dynamic data) itemBuilder;
  BaseModel model;
  UrlModel urlModel;
  bool searchable;

  UIListView(
      {@required this.itemBuilder,
      @required this.model,
      @required this.urlModel,
        this.searchable = true,
      });

  @override
  State<StatefulWidget> createState() {
    return _UIListViewState<T>();
  }
}

class _UIListViewState<T> extends State<UIListView> {
  BaseBloc baseBloc;

  var searchController = TextEditingController();
  String currentSearch = "";
  ValueNotifier<bool> showSearchLoading = ValueNotifier(false);
  ValueNotifier<bool> moreLoadingNotifier = ValueNotifier(false);
  List items = [];
  RefreshController _controller = RefreshController();
  BaseModel model;

  @override
  void initState() {
    baseBloc = BaseBloc(widget.model, widget.urlModel);
    baseBloc.add(BlocEvent.fetch);
    searchController.addListener(onSearch);
    super.initState();
  }

  void onSearch() {
    if (currentSearch != searchController.text) {
      currentSearch = searchController.text;
      showSearchLoading.value = true;
      baseBloc.search(searchController.text);
      items = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.searchable ? UISearchBar(
          controller: searchController,
          showLoadingNotifier: showSearchLoading,
        ) : SizedBox(),
        Expanded(
          child: StreamBuilder<BlocModel>(
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
                    _handleBlocEvent(snapshot.data.event);
                    model = snapshot.data.data;
                    setItems(model);
                    if (items.isEmpty) {
                      return Center(child: Text("No user found"),);
                    } else {
                      return SmartRefresher(
                        controller: _controller,
                        enablePullDown: true,
                        enablePullUp: items.length < model.total,
                        onRefresh: () {
                          items = [];
                          baseBloc.add(BlocEvent.refresh);
                        },
                        onLoading: () {
                          baseBloc.add(BlocEvent.loadMore);
                        },
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return widget.itemBuilder(
                                  context, items[index]);
                            }),
                        header: WaterDropMaterialHeader(),
                        footer: ClassicFooter(),
                      );
                    }
                }
              }),
        ),

        ValueListenableBuilder(valueListenable: moreLoadingNotifier,
            builder: (context, bool value, child) {
              if (value) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(width: 10,),
                    Text("Load more")
                  ],
              ),
                );
              } else {
                return SizedBox();
              }
            }
        )
      ],
    );
  }

  void setItems(BaseModel model) {
    try {
      items.addAll(model.data as List);
    } catch (err) {

    }
  }

  void _handleBlocEvent(BlocEvent event) {
    switch (event) {
      case BlocEvent.fetch:
        break;
      case BlocEvent.refresh:
        _controller.refreshCompleted();
        break;
      case BlocEvent.loadMore:
        _controller.loadComplete();
        break;
      case BlocEvent.search:
        showSearchLoading.value = false;
        break;
    }
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
