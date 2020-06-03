import 'package:code_brew/code_brew.dart';

///
/// project: code_brew
/// @package: repository
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-10
class Repository {
  NetworkUtil networkUtil = NetworkUtil();

  Future<T> fetchData<T extends PaginatedDataModel>(
      PaginatedDataModel modelAble, String url) async {
    T model;
    try {
      var response = await networkUtil.connectApi(url, RequestMethod.get);
      model = modelAble.fromJson(response.data);
      print(model);
    } catch (error) {
      return Future.error(error);
    }
    return model;
  }
}
