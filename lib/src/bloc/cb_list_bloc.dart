import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/models/UrlModel.dart';
import 'package:code_brew/src/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

///
/// project: code_brew
/// @package: bloc
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-11
class CBListBloc {
  PaginatedDataModel model;
  Repository repository = Repository();
  PublishSubject<BlocModel> blocController = PublishSubject<BlocModel>();

  Sink<BlocModel> get inBlocModel => blocController.sink;

  Stream<BlocModel> get outBlocModel => blocController.stream;
  BlocState currentState;
  BlocEvent currentEvent;
  UrlModel urlModel;

  CBListBloc(this.model, this.urlModel);

  void add(BlocEvent event) async {
    currentEvent = event;
    switch (event) {
      case BlocEvent.fetch:
        currentState = BlocState.moreDataLoaded;
        fetchData();
        break;
      case BlocEvent.refresh:
        urlModel.page = 1;
        currentState = BlocState.dataRefreshed;
        fetchData();
        break;
      case BlocEvent.loadMore:
        urlModel.page++;
        currentState = BlocState.moreDataLoaded;
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
    currentState = BlocState.searchingData;
    inBlocModel
        .add(BlocModel(data: model, state: currentState, event: currentEvent));
    urlModel.page = 1;
    model = await repository.fetchData<PaginatedDataModel>(
        model, urlModel.toUrl(searchTerm: searchTerm));
    currentState = BlocState.searchDataReturned;
    inBlocModel
        .add(BlocModel(data: model, state: currentState, event: currentEvent));
  }

  void fetchData() async {
    model =
        await repository.fetchData<PaginatedDataModel>(model, urlModel.toUrl());
    inBlocModel
        .add(BlocModel(data: model, state: currentState, event: currentEvent));
  }

  void dispose() {
    blocController.close();
  }
}
