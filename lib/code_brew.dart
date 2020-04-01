library code_brew;

export 'package:code_brew/src/ui/dialog/UIDialog.dart';
export 'package:code_brew/src/ui/dialog/dialog_buttons/DialogPositiveButton.dart';
export 'package:code_brew/src/ui/dialog/dialog_enum.dart';

export 'src/database/CBSessionManager.dart';
export 'src/helpers/CBUtility.dart';
export 'src/helpers/extension.dart';
export 'src/models/CBBaseModel.dart';
export 'src/models/UrlModel.dart';
export 'src/network/NetworkUtil.dart';
export 'src/ui/UIListView.dart';
export 'src/ui/UiKits.dart';
export 'src/ui/app_bars/FlatAppbar.dart';
export 'src/ui/search_widgets/UISearch.dart';
export 'src/ui/search_widgets/UISearchBar.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
