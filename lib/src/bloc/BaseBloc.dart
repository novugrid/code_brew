import 'package:code_brew/src/models/BaseModel.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/models/UrlModel.dart';
import 'package:code_brew/src/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/BaseModel.dart';

///
/// project: code_brew
/// @package: bloc
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-11
class BaseBloc {

  BaseModel model;
  Repository repository = Repository();
  PublishSubject<BlocModel> blocController = PublishSubject<BlocModel>();
  Sink<BlocModel> get inBlocModel => blocController.sink;
  Stream<BlocModel> get outBlocModel => blocController.stream;
  BlocState currentState;
  BlocEvent currentEvent;
  UrlModel urlModel;

  BaseBloc(this.model, this.urlModel);


  void add(BlocEvent event) async{
    currentEvent = event;
    switch(event) {
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
        fetchData();
        break;
      case BlocEvent.search:
        // TODO: Handle this case.
        break;
    }
  }

  void search(String searchTerm) async{
    currentEvent = BlocEvent.search;
    urlModel.page = 1;
    BaseModel data = await repository.fetchData<BaseModel>(model, urlModel.toUrl(searchTerm: searchTerm));
    inBlocModel.add(BlocModel(data: data, state: currentState, event: currentEvent));
  }

  void fetchData() async{
    BaseModel data = await repository.fetchData<BaseModel>(model, urlModel.toUrl());
    inBlocModel.add(BlocModel(data: data, state: currentState, event: currentEvent));
  }

  void dispose() {
    //blocController.close();
  }
}