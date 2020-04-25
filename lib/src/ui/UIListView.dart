import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/bloc/BaseBloc.dart';
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
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-11
class UIListView<T> extends StatefulWidget {
  Widget Function(BuildContext context, dynamic data) itemBuilder;
  PaginatedDataModel model;
  UrlModel urlModel;
  bool searchable;
  EdgeInsets padding;
  RefreshController refreshController;

  UIListView(
      {@required this.itemBuilder,
      @required this.model,
      @required this.urlModel,
        this.searchable = true,
        this.padding = EdgeInsets.zero,
        this.refreshController
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
  bool showSearchLoading = false;
  ValueNotifier<bool> moreLoadingNotifier = ValueNotifier(false);
  List items = [];
  RefreshController _controller;
  PaginatedDataModel model;
  bool showLoading;

  @override
  void initState() {
    _controller = widget.refreshController ?? RefreshController();
    baseBloc = BaseBloc(widget.model, widget.urlModel);
    baseBloc.add(BlocEvent.fetch);
    searchController.addListener(onSearch);
    super.initState();
  }

  void onSearch() {
    if (currentSearch != searchController.text) {
      currentSearch = searchController.text;
      showLoading = true;
      baseBloc.search(searchController.text);
      items = [];
    }
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
              _handleBlocState(snapshot.data);
              model = snapshot.data.data;
              return Column(
                children: <Widget>[
                  if(widget.searchable) UISearchBar(
                    controller: searchController,
                    showLoadingNotifier: ValueNotifier(showSearchLoading),
                  ),
                  if(items.isEmpty) Center(child: Text("No item found"),)
                  else
                    Expanded(
                      child: SmartRefresher(
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
                            padding: widget.padding,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return widget.itemBuilder(
                                  context, items[index]);
                            }),
                        header: WaterDropMaterialHeader(),
                        footer: ClassicFooter(),
                      ),
                    )
                ],
              );
          }
        });
  }

  void _handleBlocState(BlocModel model) {
    switch (model.state) {
      case BlocState.loading:
        break;
      case BlocState.dataLoaded:
        items = model.data.data;
        break;
      case BlocState.error:
        break;
      case BlocState.loadingMoreData:

        break;
      case BlocState.moreDataLoaded:
        items.addAll(model.data.data);
        _controller.loadComplete();
        break;
      case BlocState.dataRefreshed:
        items = model.data.data;
        _controller.refreshCompleted();
        break;
      case BlocState.searchDataReturned:
        showSearchLoading = false;
        items = model.data.data;
        break;
      case BlocState.searchingData:
        showSearchLoading = true;
        items = model.data.data;
        break;
    }
  }

  @override
  void dispose() {
    baseBloc.dispose();
    super.dispose();
  }
}
