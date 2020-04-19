import 'dart:async';

import 'package:code_brew/code_brew.dart';
import 'package:code_brew/src/network/ApiError.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CBEmailLoginBloc {
  EmailLoginParams uiModel = EmailLoginParams();

  NetworkUtil _networkUtil;
  
  PublishSubject<bool> loginSuccessSubject = PublishSubject();

  CBEmailLoginBloc() {
    _networkUtil = NetworkUtil();
  }
  
  dispose() {
    loginSuccessSubject.close();
  }

  login() async {
    loginSuccessSubject.add(null); // Hack hack haq haqqqq!!!!1
    try {
      Response response = await _networkUtil.connectApi(
        "",
        RequestMethod.post,
        data: uiModel.toRequestParams(),
      );
      // ui
      // Todo(Login): yeild the model we passed in to save the user info, 
      loginSuccessSubject.add(true);
    } on ApiError catch (apiError) {
      // ui buzz
      loginSuccessSubject.addError(apiError);
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
