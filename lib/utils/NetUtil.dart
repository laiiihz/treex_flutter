import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetUtil {
  String path;
  NetUtil({@required this.path});
  Future<Object> getResult() async {
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
  Future<Object> getToken() async {
    return await NetUtil(
      path: 'http://${this.serverPrefix}/api/login?'
          'name=${this.userName}&'
          'password=${this.password}',
    ).getResult();
  }
}

class UserExistUtil {
  String name;
  String serverPrefix;
  UserExistUtil({
    @required this.name,
    @required this.serverPrefix,
  });
  Future<Object> check() async {
    return await NetUtil(path: 'http://${this.serverPrefix}/api/existuser?'
        'name=${this.name}').getResult();
  }
}
