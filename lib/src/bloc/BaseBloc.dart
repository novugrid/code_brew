import 'package:code_brew/src/models/BaseModel.dart';
import 'package:code_brew/src/models/BlocModel.dart';
import 'package:code_brew/src/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/BaseModel.dart';

///
/// project: code_brew
/// @package: bloc
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-11
class BaseBloc {

  BaseModel model;
  Repository repository = Repository();
  PublishSubject<BlocModel> blocController = PublishSubject<BlocModel>();
  Sink<BlocModel> get inBlocModel => blocController.sink;
  Stream<BlocModel> get outBlocModel => blocController.stream;


  BaseBloc(this.model);

  void add(BlocEvent event) async{
    switch(event) {
      case BlocEvent.fetch:
        fetchData();
        break;
      case BlocEvent.refresh:
        //inBlocModel.add(BlocModel(state: BlocState.loading));
        fetchData();
        break;
      case BlocEvent.loadMore:
        break;
    }
  }

  void fetchData() async{
    BaseModel data = await repository.fetchData<BaseModel>(model, "https://jsonplaceholder.typicode.com/todos");
    inBlocModel.add(BlocModel(data: data, state: BlocState.dataLoaded));
  }

  void dispose() {
    blocController.close();
  }
}