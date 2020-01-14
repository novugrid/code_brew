import 'package:super_enum/super_enum.dart';


part 'base_event.g.dart';

///
/// project: code_brew
/// @package: bloc.events
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-10

@superEnum
enum _BaseEvent {
  @object
  Refresh,
  @object
  LoadData,
  @Data(fields: [DataField("currentPage", num)])
  LoadMore,
}