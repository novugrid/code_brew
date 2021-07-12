import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/network/ApiError.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class CBEmailLoginBloc {
  String emailLoginUrl = "";
  EmailLoginParams emailLoginParams = EmailLoginParams();

  NetworkUtil _networkUtil;
  BehaviorSubject<ApiCallStates> loginSubject =
      BehaviorSubject.seeded(ApiCallStates.IDLE);

  // Data
  dynamic loginResponse;

  CBEmailLoginBloc() {
    _networkUtil = NetworkUtil();
  }

  dispose() {
    loginSubject.close();
  }

  emailLogin() async {
    loginSubject.add(ApiCallStates.LOADING); // Hack hack haq haqqqq!!!!1
    try {
      Response response = await _networkUtil.connectApi(
        emailLoginUrl,
        RequestMethod.post,
        data: emailLoginParams.toRequestParams(),
      );
      loginResponse = response.data;
      loginSubject.add(ApiCallStates.SUCCESS);
    } on CBApiError catch (apiError) {
      loginSubject.addError(apiError);
      loginSubject.add(ApiCallStates.ERROR);
    } catch (e) {
      loginSubject.addError(e);
      print(e.toString());
    }
  }
}

class EmailLoginParams {
  String email;
  String password;

  Map<String, dynamic> toRequestParams() {
    return {
      "email": email,
      "password": password,
    };
  }
}
