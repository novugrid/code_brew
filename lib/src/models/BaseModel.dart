///
/// project: code_brew
/// @package: models
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-10
abstract class BaseModel<T> {

  String message;
  bool success;
  T data;
  int total, currentPage;

  fromJson(List data);

}