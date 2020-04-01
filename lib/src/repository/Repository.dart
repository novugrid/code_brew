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
    Dio dio =  new Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
    return dio;
  }

  Future<T> fetchData<T>(CBBaseModel modellAble, String url) async {
    T model; // should
    try {
      var response  = await getDio().get(url);
      if(response.statusCode == 200 ) {

        model = modellAble.fromJson(response.data);
        print(model);
      }
    } catch (error) {
      print("an error has occured $error");
    }
    return model;
  }
}