import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/network/NetworkUtil.dart';
import 'package:code_brew/src/ui/list/smart_refresher/smart_refresher.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UIListView<T extends CBBaseListViewModel> extends StatefulWidget {

  final Widget Function(BuildContext context, T data, int index, bool isSelected) itemBuilder;
  final int Function(T data) itemCounter;
  final int itemCount;
  final bool searchable;
  final EdgeInsetsGeometry padding;
  final bool multiSelectEnabled;
  final int maxSelectionCount;
  final int minSelectionCount;
  final ValueChanged<bool> onMaxMultiSelectionCompleted; // Max
  final ValueChanged<bool> onMinMultiSelectionCompleted;
  final ValueChanged<bool> onMultiSelection;
  final RefreshController refreshController;
  final String url;
  T responseModel;
  final Widget separator;


  UIListView({
    @required this.itemBuilder,
    this.itemCounter,
//    this.model,
//    this.urlModel,
    this.searchable = false,
    this.itemCount = 0,
    this.padding = EdgeInsets.zero,
    this.multiSelectEnabled = false,
    this.maxSelectionCount,
    this.minSelectionCount = 1,
    this.refreshController,
    this.onMaxMultiSelectionCompleted,
    this.onMinMultiSelectionCompleted,
    this.onMultiSelection,
    this.url,
    this.responseModel,
    this.separator,
  })  : assert(itemCount != null),
        assert(
        multiSelectEnabled ? onMaxMultiSelectionCompleted != null : true);

  @override
  _UIListViewState createState() => _UIListViewState<T>();

}

class _UIListViewState<T extends CBBaseListViewModel> extends State<UIListView> {

  ListBloc listBloc;

  RefreshController _refreshController = RefreshController();

  List items = [];
  List<int> selectedItems = [];

  @override
  void initState() {
    super.initState();
    listBloc = ListBloc();
    listBloc.responseModel = widget.responseModel;

    if (widget.url == null) { // should be replaces by a better check

      listBloc.apiSubject.add(ApiCallStates.SUCCESS);

    } else {
      listBloc.url = widget.url;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listBloc.fetch();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<ApiCallStates>(
          stream: listBloc.apiSubject,
          builder: (context, snapshot) {

            if (snapshot.hasError) {
              return Container(child: Text("Error Loading Items"),);
            }

            if (snapshot.data == ApiCallStates.IDLE || snapshot.data == ApiCallStates.LOADING) {
              return Expanded(child: Center(child: CircularProgressIndicator()));
            }

            if (snapshot.data == ApiCallStates.SUCCESS) {
              return Expanded(
                child: ListView.separated(
                  itemCount: widget.itemCounter != null ? widget.itemCounter(listBloc.responseModel) : widget.itemCount,
                  padding: widget.padding,
                  separatorBuilder: (context, index) {
                    return widget.separator != null ? widget.separator : Container();
                  },
                  itemBuilder: (ctx, index) {

                    /// Get the data being return from the server
                    Widget listItem = widget.itemBuilder(ctx, listBloc.responseModel, index, selectedItems.contains(index));

                    if (widget.multiSelectEnabled) {
                      listItem = GestureDetector(
                        onTap: () {
                          if (this.selectedItems.contains(index)) {
                            this.selectedItems.remove(index);
                            /// Once a max selection count is non null, that mean the completion is false
                            widget.onMaxMultiSelectionCompleted(
                                widget.maxSelectionCount == null);

                            if (widget.minSelectionCount > this.selectedItems.length) {
                              widget.onMinMultiSelectionCompleted(false);
                            }

                          } else { //

                            if (widget.maxSelectionCount == null) {
                              this.selectedItems.add(index);
                            } else {
                              if (widget.maxSelectionCount > this.selectedItems.length) {
                                this.selectedItems.add(index);
                              }
                            }

                            /// Check for the minimum selection
                            if (widget.minSelectionCount > 0) {
                              if (widget.minSelectionCount <=
                                  this.selectedItems.length) {
                                widget.onMinMultiSelectionCompleted(true);
                              } else {
                                widget.onMinMultiSelectionCompleted(false);
                              }
                            }

                            /// Checks for the max selection count and fires a completed true if selection count has been met
                            if (widget.maxSelectionCount != null) {
                              if (widget.maxSelectionCount >
                                  this.selectedItems.length) {
                                // this.selectedItems.add(index);
                                widget.onMaxMultiSelectionCompleted(
                                    widget.maxSelectionCount ==
                                        this.selectedItems.length);
                              } else {
                                widget.onMaxMultiSelectionCompleted(
                                    true); // completed is true
                              }
                            } else {
                              // this.selectedItems.add(index);
                              widget.onMaxMultiSelectionCompleted(true);
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
              );
            }

            return Container();

          }
        ),
      ],
    );
  }

  Widget listView() {

  }

}

class ListBloc<T extends CBBaseListViewModel> {

  BehaviorSubject<ApiCallStates> apiSubject = BehaviorSubject.seeded(ApiCallStates.IDLE);

  String url = "";
  // List<T> items = [];
  T responseModel;
//  T data;

  void close() {
    apiSubject.close();
  }

  fetch() async {
    apiSubject.add(ApiCallStates.LOADING);
    try {

      var response = await NetworkUtil().connectApi(url, RequestMethod.get);
      responseModel.fromJson(response.data);

      apiSubject.add(ApiCallStates.SUCCESS);

    } catch (e) {
      apiSubject.addError(e);
    }
  }



}
