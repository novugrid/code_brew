import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/models/CBBaseModel.dart';
import 'package:dio/dio.dart';

///
/// project: code_brew
/// @package: repository
/// @author dammyololade <dammyololade2010@gmail.com>
/// created on 2020-01-10
class Repository {
  Dio dio = new Dio();

  Dio getDio() {
    Dio dio = new Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
    return dio;
  }

  Future<T> fetchData<T extends PaginatedDataModel>(
      PaginatedDataModel modelAble, String url) async {
    T model;
    try {
      var response = await getDio().get(url);
      if (response.statusCode == 200) {
        model = modelAble.fromJson(response.data);
        print(model);
      }
    } catch (error) {
      print("an error has occured $error");
    }
    return model;
  }
}
