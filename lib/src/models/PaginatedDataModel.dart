/// description:
/// project: code_brew
/// @package:
/// @author: dammyololade
/// created on: 04/04/2020
abstract class PaginatedDataModel<T> {
  int total, currentPage, nextPage, previousPage, limit;
  List<T> data;
  String message;
  bool success;

  PaginatedDataModel<T> fromJson(Map<String, dynamic> data) {
    total = data["data"]["total"];
    currentPage = data["data"]["current_page"];
    nextPage = data["data"]["next_page"];
    previousPage = data["data"]["previous_page"];
    limit = data["data"]["limit"];
    message = data["message"];
    success = data["success"];
  }
}
