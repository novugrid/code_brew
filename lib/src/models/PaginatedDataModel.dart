/// description:
/// project: code_brew
/// @package:
/// @author: dammyololade
/// created on: 04/04/2020
abstract class PaginatedDataModel<T> {
  int total, currentPage, nextPage, previousPage, limit, totalPage;
  List<T> data;
  String message;
  bool success;

  PaginatedDataModel<T> fromJson(Map<String, dynamic> data) {
    total = data["total"] ?? this.data.length;
    currentPage = data["current_page"];
    nextPage = data["next_page"];
    previousPage = data["previous_page"];
    totalPage = data["total_page"];
    limit = data["limit"];
    if (totalPage == null && limit != null) {
      totalPage = (total / limit).round();
    }
  }
}
