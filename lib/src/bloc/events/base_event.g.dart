// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class BaseEvent extends Equatable {
  const BaseEvent(this._type);

  factory BaseEvent.refresh() = Refresh;

  factory BaseEvent.loadData() = LoadData;

  factory BaseEvent.loadMore({@required num currentPage}) = LoadMore;

  final _BaseEvent _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Refresh) refresh,
      @required R Function(LoadData) loadData,
      @required R Function(LoadMore) loadMore}) {
    switch (this._type) {
      case _BaseEvent.Refresh:
        return refresh(this as Refresh);
      case _BaseEvent.LoadData:
        return loadData(this as LoadData);
      case _BaseEvent.LoadMore:
        return loadMore(this as LoadMore);
    }
  }

  @override
  List get props => null;
}

@immutable
class Refresh extends BaseEvent {
  const Refresh._() : super(_BaseEvent.Refresh);

  factory Refresh() {
    _instance ??= Refresh._();
    return _instance;
  }

  static Refresh _instance;
}

@immutable
class LoadData extends BaseEvent {
  const LoadData._() : super(_BaseEvent.LoadData);

  factory LoadData() {
    _instance ??= LoadData._();
    return _instance;
  }

  static LoadData _instance;
}

@immutable
class LoadMore extends BaseEvent {
  const LoadMore({@required this.currentPage}) : super(_BaseEvent.LoadMore);

  final num currentPage;

  @override
  String toString() => 'LoadMore(currentPage:${this.currentPage})';
  @override
  List get props => [currentPage];
}
