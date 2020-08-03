import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/ui/list/smart_refresher/smart_refresher.dart';
import 'package:flutter/material.dart';

class UIPaginatedDataTable extends StatefulWidget {
//  List<DataRow> Function(BuildContext context, dynamic data) rowItemBuilder;
  DataRow Function(int index, dynamic data) rowItemBuilder;
  int Function(dynamic data) totalRows;
  PaginatedDataModel model;
  UrlModel urlModel;
  List<DataColumn> headers;
  Widget pageHeader;
  bool isSearchable, shouldPaginate;
  CBListBloc bloc;

  UIPaginatedDataTable({
    @required this.headers,
    @required this.urlModel,
    @required this.model,
    @required this.rowItemBuilder,
    @required this.totalRows,
    this.bloc,
    this.pageHeader = const SizedBox(),
    this.isSearchable = true,
    this.shouldPaginate = true,
  });

  @override
  _UIPaginatedDataTableState createState() => _UIPaginatedDataTableState();
}

class _UIPaginatedDataTableState extends State<UIPaginatedDataTable> {
  CBListBloc baseBloc;
  var _searchController = TextEditingController();
  String currentSearch = "";
  List items = [];
  RefreshController _controller = RefreshController();
  PaginatedDataModel model;

  // UI Props
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  _UITableDataSource _uiTableDataSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//    _uiTableDataSource ??= _UITableDataSource(context, data: model, rowItemBuilder: widget.rowItemBuilder, totalRows: model?.totalPage ?? 0);
  }

  @override
  void initState() {
    baseBloc = widget.bloc ?? CBListBloc(widget.model, widget.urlModel);
    baseBloc.add(BlocEvent.fetch);
    _searchController.addListener(() {
      if (_searchController.text != currentSearch) {
        currentSearch = _searchController.text;
        baseBloc.search(currentSearch);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Our Header Widget
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
                  _uiTableDataSource ??= _UITableDataSource(context, rowItemBuilder: widget.rowItemBuilder, totalRows: widget.totalRows);
                  _uiTableDataSource.data = model;
                  return Scrollbar(
                    child: ListView(
                      children: [
                        PaginatedDataTable(
                          showCheckboxColumn: false,
                          header: Text(""),
                          columns: widget.headers,
                          source: _uiTableDataSource,
                        )
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _UITableDataSource extends DataTableSource {

  final BuildContext context;
  final DataRow Function(int index, dynamic data) rowItemBuilder;
  final int Function(dynamic data) totalRows;
  // We need to make the data updatable
  dynamic data;


  _UITableDataSource(this.context, {this.data, this.rowItemBuilder, this.totalRows});

  @override
  DataRow getRow(int index) {
    return rowItemBuilder(index, data);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data == null ? 0 : totalRows(data);

  @override
  int get selectedRowCount => 0;
}
