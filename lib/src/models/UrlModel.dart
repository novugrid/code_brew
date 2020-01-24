import 'package:flutter/material.dart';

///
/// project: code_brew
/// @package:
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-24
class UrlModel {

  /// the base url for the request
  /// such as https://google.com
  ///
  /// kindly ensure no slash is added to end of the url
  /// this will be automatically added when you call toUrl()
  String baseUrl;

  /// The search url, if this is not specified and search action is triggered
  /// the base url will be assumed as the search url too
  ///
  String searchUrl;

  /// the search key that will be passed to the search endpoint
  ///
  /// e.g searchTerm
  /// ---> https://google.com/search?searchTerm=.....
  String searchKey;

  /// useful for pagination
  /// initial request will be page = 1
  int page;

  /// For pagination
  /// null if not specified
  int limit;


  UrlModel({@required this.baseUrl,
    this.searchUrl,
    this.searchKey,
    this.page = 1,
    this.limit});

  /// build the url into a string
  String toUrl({String searchTerm}) {
    String url = searchTerm != null ? "$searchUrl?$searchKey=$searchTerm" :
        baseUrl;
    if (limit != null && limit != 0) {
      url += "?page=$page&limit=$limit";
    }
    return url;
  }
}
