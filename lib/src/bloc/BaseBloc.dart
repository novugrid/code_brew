
import 'package:bloc/bloc.dart';
import 'package:code_brew/src/bloc/states/base_state.dart';
import 'package:code_brew/src/bloc/events/base_event.dart';
import 'package:code_brew/src/models/BaseModel.dart';
import 'package:code_brew/src/repository/Repository.dart';

///
/// project: code_brew
/// @package: bloc
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-11
class BaseBloc extends Bloc<BaseEvent, BaseState>{

  Repository repository = Repository();
  BaseModel modellable;

  @override
  // TODO: implement initialState
  BaseState get initialState => BaseState.loading();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async*{
    try {
      yield BaseState.loading();
      yield* event.when(
        refresh: null,
        loadData: (e) async*{
          BaseModel data = await repository.fetchData<BaseModel>(modellable, "https://jsonplaceholder.typicode.com/todos");
          yield BaseState.loaded(data: data);
        },
        loadMore: null
      );
    } catch (error) {
      yield BaseState.error(message: error.toString());
    }
  }
}