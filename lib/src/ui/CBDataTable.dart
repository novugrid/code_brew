import 'package:code_brew/src/bloc/BaseBloc.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/models/CBBaseModel.dart';
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
  CBBaseModel model;
  UrlModel urlModel;
  List<DataColumn> headers;

  @override
  State<StatefulWidget> createState() {
    return _CBDataTableState();
  }
}

class _CBDataTableState extends State<CBDataTable> {
  BaseBloc baseBloc;
  var searchController = TextEditingController();
  String currentSearch = "";
  List items = [];
  RefreshController _controller = RefreshController();
  CBBaseModel model;

  @override
  void initState() {
    baseBloc = BaseBloc(widget.model, widget.urlModel);
    baseBloc.add(BlocEvent.fetch);
    //searchController.addListener(onSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                      return DataTable(
                          columns: widget.headers,
                          rows: _buildDataRow(model.data));
                  }
                }))
      ],
    );
  }

  List<DataRow> _buildDataRow(dynamic data) {
    return widget.rowItemBuilder(context, data);
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
        break;
    }
  }

  @override
  void dispose() {
    baseBloc.dispose();
    super.dispose();
  }
}
