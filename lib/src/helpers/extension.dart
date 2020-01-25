///
/// project: code_brew
/// @package:
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-24

extension StringExtension on String {
  /// checks if a string is null or empty
  bool get isNullOrEmpty => this == null || this.isEmpty;
}

class Str {
  String dart = "2";

  Str() {
    dart.isNullOrEmpty;
  }
}
