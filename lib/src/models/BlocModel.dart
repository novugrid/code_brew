import 'package:code_brew/code_brew.dart';

import 'CBBaseModel.dart';

///
/// project: code_brew
/// @package: 
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-23
class BlocModel<T extends PaginatedDataModel> {
  T data;
  BlocState state;
  BlocEvent event;

  BlocModel({this.data, this.state, this.event});

}

enum BlocState {
  loading,
  dataLoaded,
  error,
  loadingMoreData,
}

enum BlocEvent {
  fetch,
  refresh,
  loadMore,
  search,
  loadPrevious,
}