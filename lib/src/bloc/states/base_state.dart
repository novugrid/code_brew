import 'package:code_brew/src/models/BaseModel.dart';
import 'package:super_enum/super_enum.dart';

part 'base_state.g.dart';

///
/// project: code_brew
/// @package: bloc.states
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-1


@superEnum
enum _BaseState{

  @object
  Initial,
  @object
  Loading,
  @Data(fields: [DataField("data", BaseModel)])
  DataRefreshed,
  // @generic
  @Data(fields: [DataField("data", BaseModel)])
  Loaded,
  @Data(fields: [DataField("message", String)])
  Error
}