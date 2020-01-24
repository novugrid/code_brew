import 'BaseModel.dart';

///
/// project: code_brew
/// @package: 
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-23
class BlocModel<T extends BaseModel> {
  T data;
  BlocState state;
  BlocEvent event;

  BlocModel({this.data, this.state, this.event});

}

enum BlocState {
  loading,
  dataLoaded,
  error
}

enum BlocEvent {
  fetch,
  refresh,
  loadMore,
  search,
}