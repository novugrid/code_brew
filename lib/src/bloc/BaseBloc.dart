import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/models/CBBaseModel.dart';
import 'package:code_brew/src/models/UrlModel.dart';
import 'package:code_brew/src/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/CBBaseModel.dart';

///
/// project: code_brew
/// @package: bloc
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-11
class BaseBloc {
  PaginatedDataModel model;
  Repository repository = Repository();
  PublishSubject<BlocModel> blocController = PublishSubject<BlocModel>();

  Sink<BlocModel> get inBlocModel => blocController.sink;

  Stream<BlocModel> get outBlocModel => blocController.stream;
  BlocState currentState;
  BlocEvent currentEvent;
  UrlModel urlModel;

  BaseBloc(this.model, this.urlModel);

  void add(BlocEvent event) async {
    currentEvent = event;
    switch (event) {
      case BlocEvent.fetch:
        fetchData();
        break;
      case BlocEvent.refresh:
        //inBlocModel.add(BlocModel(state: BlocState.loading));
        urlModel.page = 1;
        fetchData();
        break;
      case BlocEvent.loadMore:
        urlModel.page++;
        currentState = BlocState.loadingMoreData;
        inBlocModel.add(
            BlocModel(data: model, state: currentState, event: currentEvent));
        fetchData();
        break;
      case BlocEvent.search:

        break;
      case BlocEvent.loadPrevious:
        urlModel.page--;
        currentState = BlocState.loadingMoreData;
        inBlocModel.add(
            BlocModel(data: model, state: currentState, event: currentEvent));
        fetchData();
        break;
    }
  }

  void search(String searchTerm) async {
    currentEvent = BlocEvent.search;
    urlModel.page = 1;
    PaginatedDataModel data = await repository.fetchData<PaginatedDataModel>(
        model, urlModel.toUrl(searchTerm: searchTerm));
    inBlocModel
        .add(BlocModel(data: data, state: currentState, event: currentEvent));
  }

  void fetchData() async {
    model =
        await repository.fetchData<PaginatedDataModel>(model, urlModel.toUrl());
    currentState = BlocState.dataLoaded;
    inBlocModel
        .add(BlocModel(data: model, state: currentState, event: currentEvent));
  }

  void dispose() {
    blocController.close();
  }
}
