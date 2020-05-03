import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/bloc/BaseBloc.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/models/CBBaseModel.dart';
import 'package:code_brew/src/ui/list/smart_refresher/indicator/classic_indicator.dart';
import 'package:code_brew/src/ui/list/smart_refresher/indicator/material_indicator.dart';
import 'package:code_brew/src/ui/list/smart_refresher/smart_refresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/BaseBloc.dart';

/// created on 2020-01-11
/// [urlModel] if availble make a network call else just use the count to generate a list
/// [itemCount] must not be null when [urlModel] is null also
/// [onMultiSelection] tells if a selection max count condition has been met
class UIListView<T> extends StatefulWidget {
  final Widget Function(
          BuildContext context, dynamic data, int index, bool isSelected)
      itemBuilder;
  final PaginatedDataModel model;
  final UrlModel urlModel;
  final bool searchable;
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final bool multiSelectEnabled;
  final int maxSelectionCount;
  final ValueChanged<bool> onMultiSelection;
  RefreshController refreshController;

  UIListView(
      {@required this.itemBuilder,
      this.model,
      this.urlModel,
      this.searchable = false,
      this.itemCount = 0,
      this.padding = EdgeInsets.zero,
      this.multiSelectEnabled = false,
      this.maxSelectionCount,
        this.refreshController,
      this.onMultiSelection})
      : assert(itemCount != null),
        assert(multiSelectEnabled ? onMultiSelection != null : true);

  @override
  State<StatefulWidget> createState() {
    return _UIListViewState<T>();
  }
}

class _UIListViewState<T> extends State<UIListView> {
  BaseBloc baseBloc;

  var searchController = TextEditingController();
  String currentSearch = "";
  ValueNotifier<bool> moreLoadingNotifier = ValueNotifier(false);
  RefreshController _controller = RefreshController();
  PaginatedDataModel model;
  bool showSearchLoading = false;
  bool showLoading;

  List items = [];
  List<int> selectedItems = [];

  @override
  void initState() {
    if (widget.urlModel != null) {
      _controller = widget.refreshController ?? RefreshController();
      baseBloc = BaseBloc(widget.model, widget.urlModel);
      baseBloc.add(BlocEvent.fetch);
      searchController.addListener(onSearch);
    }

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
    return Column(
      children: <Widget>[
        if (widget.urlModel != null)
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
                      _handleBlocState(snapshot.data);
                      model = snapshot.data.data;
                      return Column(
                        children: <Widget>[
                          if(widget.searchable) UISearchBar(
                            controller: searchController,
                            showLoadingNotifier: ValueNotifier(
                                showSearchLoading),
                          ),
                          if(items.isEmpty) Center(
                            child: Text("No item found"),)
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
                                          context, items[index], index, false);
                                    }),
                                header: WaterDropMaterialHeader(),
                                footer: ClassicFooter(),
                              ),
                            )
                        ],
                      );
                  }
                }),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: widget.itemCount,
              padding: widget.padding,
              itemBuilder: (ctx, index) {
                Widget listItem = widget.itemBuilder(
                    ctx, null, index, selectedItems.contains(index));
                if (widget.multiSelectEnabled) {
                  listItem = GestureDetector(
                    onTap: () {
                      if (this.selectedItems.contains(index)) {
                        this.selectedItems.remove(index);

                        /// Once a max selection count is non null, that mean the completion is false
                        widget
                            .onMultiSelection(widget.maxSelectionCount == null);
                      } else {
                        /// Checks for the max selection count and fires a completed true if selection count has been met
                        if (widget.maxSelectionCount != null) {
                          if (widget.maxSelectionCount >
                              this.selectedItems.length) {
                            this.selectedItems.add(index);
                            widget.onMultiSelection(widget.maxSelectionCount ==
                                this.selectedItems.length);
                          } else {
                            widget.onMultiSelection(true); // completed is true
                          }
                        } else {
                          this.selectedItems.add(index);
                          widget.onMultiSelection(true);
                        }
                      }
                      // print("Activate Multiple Selection..>\n ${this.selectedItems}");
                      setState(() {});
                    },
                    child: listItem,
                  );
                }
                return listItem;
              },
            ),
          ),
        ValueListenableBuilder(
            valueListenable: moreLoadingNotifier,
            builder: (context, bool value, child) {
              if (value) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(width: 10),
                      Text("Load more")
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            })
      ],
    );
  }

  void setItems(PaginatedDataModel model) {
    try {
      items.addAll(model.data);
    } catch (err) {}
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


  int getItemCount(CBBaseModel model) {
    if (model.data is List) {
      return model.data.total;
    }
//    if (data is Map)
    return 0;
  }

  @override
  void dispose() {
    if (widget.urlModel != null) {
      baseBloc.dispose();
    }
    super.dispose();
  }
}
