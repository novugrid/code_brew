///
/// project: code_brew
/// @package: models
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-10
abstract class CBBaseModel<T> {

  String message;
  bool success;
  T data;
  int total, currentPage;

  fromJson(Map<String, dynamic> data);

}