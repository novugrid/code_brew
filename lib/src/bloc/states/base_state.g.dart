// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class BaseState extends Equatable {
  const BaseState(this._type);

  factory BaseState.initial() = Initial;

  factory BaseState.loading() = Loading;

  factory BaseState.dataRefreshed({@required BaseModel<dynamic> data}) =
      DataRefreshed;

  factory BaseState.loaded({@required BaseModel<dynamic> data}) = Loaded;

  factory BaseState.error({@required String message}) = Error;

  final _BaseState _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Initial) initial,
      @required R Function(Loading) loading,
      @required R Function(DataRefreshed) dataRefreshed,
      @required R Function(Loaded) loaded,
      @required R Function(Error) error}) {
    switch (this._type) {
      case _BaseState.Initial:
        return initial(this as Initial);
      case _BaseState.Loading:
        return loading(this as Loading);
      case _BaseState.DataRefreshed:
        return dataRefreshed(this as DataRefreshed);
      case _BaseState.Loaded:
        return loaded(this as Loaded);
      case _BaseState.Error:
        return error(this as Error);
    }
  }

  @override
  List get props => null;
}

@immutable
class Initial extends BaseState {
  const Initial._() : super(_BaseState.Initial);

  factory Initial() {
    _instance ??= Initial._();
    return _instance;
  }

  static Initial _instance;
}

@immutable
class Loading extends BaseState {
  const Loading._() : super(_BaseState.Loading);

  factory Loading() {
    _instance ??= Loading._();
    return _instance;
  }

  static Loading _instance;
}

@immutable
class DataRefreshed extends BaseState {
  const DataRefreshed({@required this.data}) : super(_BaseState.DataRefreshed);

  final BaseModel<dynamic> data;

  @override
  String toString() => 'DataRefreshed(data:${this.data})';
  @override
  List get props => [data];
}

@immutable
class Loaded extends BaseState {
  const Loaded({@required this.data}) : super(_BaseState.Loaded);

  final BaseModel<dynamic> data;

  @override
  String toString() => 'Loaded(data:${this.data})';
  @override
  List get props => [data];
}

@immutable
class Error extends BaseState {
  const Error({@required this.message}) : super(_BaseState.Error);

  final String message;

  @override
  String toString() => 'Error(message:${this.message})';
  @override
  List get props => [message];
}
