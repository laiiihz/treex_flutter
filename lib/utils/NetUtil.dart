import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetUtil {
  String path;
  NetUtil({@required this.path});
  Future<String> getResult() async {
    Dio dio = Dio();
    Response response;
    response = await dio.get(path);
    return response.data;
  }
}

class LoginUtil {
  String userName;
  String password;
  String serverPrefix;
  LoginUtil({
    @required this.userName,
    @required this.password,
    @required this.serverPrefix,
  });
  Future<String> getToken() async {
    return await NetUtil(
      path: 'http://${this.serverPrefix}/login?'
          'userName=${this.userName}&'
          'password=${this.password}',
    ).getResult();
  }
}
