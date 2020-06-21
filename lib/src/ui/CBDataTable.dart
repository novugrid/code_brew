import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/bloc/cb_list_bloc.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/models/UrlModel.dart';
import 'package:flutter/material.dart';

import 'list/smart_refresher/smart_refresher.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade
/// created on 04/04/2020

class CBDataTable extends StatefulWidget {
  List<DataRow> Function(BuildContext context, dynamic data) rowItemBuilder;
  PaginatedDataModel model;
  UrlModel urlModel;
  List<DataColumn> headers;
  Widget pageHeader;
  bool isSearchable, shouldPaginate;
  CBListBloc bloc;

  CBDataTable(
      {@required this.headers,
      @required this.urlModel,
      @required this.model,
      @required this.rowItemBuilder,
        this.bloc,
        this.pageHeader = const SizedBox(),
        this.isSearchable = true,
        this.shouldPaginate = true,
      });

  @override
  State<StatefulWidget> createState() {
    return _CBDataTableState();
  }
}

class _CBDataTableState extends State<CBDataTable> {
  CBListBloc baseBloc;
  var _searchController = TextEditingController();
  String currentSearch = "";
  List items = [];
  RefreshController _controller = RefreshController();
  PaginatedDataModel model;

  @override
  void initState() {
    baseBloc = widget.bloc ?? CBListBloc(widget.model, widget.urlModel);
    baseBloc.add(BlocEvent.fetch);
    _searchController.addListener((){
      if(_searchController.text != currentSearch) {
        currentSearch = _searchController.text;
        baseBloc.search(currentSearch);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(child: widget.pageHeader),
            if(widget.isSearchable) Container(
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              width: 300,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.lightBlue, width: 1)),
                  border:
                      OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffB7B7B7), width: 1)),
                  enabledBorder:
                      OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffB7B7B7), width: 1)),
                  suffixIcon: Icon(Icons.search),
                  errorBorder: InputBorder.none,
                ),
                style: Theme.of(context).inputDecorationTheme.labelStyle,
              ),
            )
          ],
        ),

        Expanded(
            child: StreamBuilder(
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
                      model = snapshot.data.data;
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: DataTable(

                                      showCheckboxColumn: false,
                                      columns: widget.headers,
                                      rows: _buildDataRow(model),

                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            if(widget.shouldPaginate)
                            if (snapshot.data.state !=
                                BlocState.loadingMoreData)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.grey.withOpacity( model.previousPage < 1 ? .5 : .9),
                                        size: 18,
                                      ),
                                      onPressed: model.previousPage < 1
                                          ? null
                                          : () {
                                              baseBloc
                                                  .add(BlocEvent.loadPrevious);
                                            }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "${model.currentPage} of ${model.totalPage}",
                                      style: TextStyle(
                                          fontFamily: "ABook", fontSize: 14),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 18,
                                      ),

                                      ///todo we need to add totalpages to the response
                                      onPressed: model.currentPage ==
                                              model.nextPage
                                          ? null
                                          : () {
                                              baseBloc.add(BlocEvent.loadMore);
                                            }),
                                ],
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[CircularProgressIndicator()],
                              ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                  }
                }))
      ],
    );
  }

  List<DataRow> _buildDataRow(dynamic data) {
    return widget.rowItemBuilder(context, data);
  }

  @override
  void dispose() {
    baseBloc.dispose();
    super.dispose();
  }
}
