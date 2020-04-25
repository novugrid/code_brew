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

  UIListView(
      {@required this.itemBuilder,
      this.model,
      this.urlModel,
      this.searchable = false,
      this.itemCount = 0,
      this.padding = EdgeInsets.zero,
      this.multiSelectEnabled = false,
      this.maxSelectionCount,
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
  ValueNotifier<bool> showSearchLoading = ValueNotifier(false);
  ValueNotifier<bool> moreLoadingNotifier = ValueNotifier(false);
  RefreshController _controller = RefreshController();
  PaginatedDataModel model;

  List items = [];
  List<int> selectedItems = [];

  @override
  void initState() {
    if (widget.urlModel != null) {
      baseBloc = BaseBloc(widget.model, widget.urlModel);
      baseBloc.add(BlocEvent.fetch);
      searchController.addListener(onSearch);
    }

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
        widget.searchable
            ? UISearchBar(
                controller: searchController,
                showLoadingNotifier: showSearchLoading,
              )
            : SizedBox(),
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
                      _handleBlocEvent(snapshot.data.event);
                      model = snapshot.data.data;
                      setItems(model);
                      if (items.isEmpty) {
                        return Center(
                          child: Text("No user found"),
                        );
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
                                    context, items[index], index, false);
                              }),
                          header: WaterDropMaterialHeader(),
                          footer: ClassicFooter(),
                        );
                      }
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
                        widget.onMultiSelection(widget.maxSelectionCount == null);

                      } else {
                        /// Checks for the max selection count and fires a completed true if selection count has been met
                        if (widget.maxSelectionCount != null) {
                          if (widget.maxSelectionCount > this.selectedItems.length) {
                            this.selectedItems.add(index);
                            widget.onMultiSelection(widget.maxSelectionCount == this.selectedItems.length);
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
      default:
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
