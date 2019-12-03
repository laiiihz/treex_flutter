import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treex_flutter/utils/PasswordGen.dart';

class NetUtil {
  String path;
  Dio _dio;
  Response _response;
  NetUtil({@required this.path}) {
    _dio = Dio();
  }
  Future<Object> get() async {
    _response = await _dio.get(path);
    return _response.data;
  }

  Future<Object> post() async {
    _response = await _dio.post(path);
    return _response.data;
  }

  Future<Object> put() async {
    _response = await _dio.put(path);
    return _response.data;
  }

  Future<Object> delete() async {
    _response = await _dio.delete(path);
    return _response.data;
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
          'password=${genPasswordHMAC(rawPassword: this.password, mixed: this.userName)}',
    ).get();
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
    return await NetUtil(
            path: 'http://${this.serverPrefix}/api/existuser?'
                'name=${this.name}')
        .get();
  }
}

class CreateANewUserUtil {
  String name;
  String password;
  String serverPrefix;
  CreateANewUserUtil({
    @required this.name,
    @required this.password,
    @required this.serverPrefix,
  });
  Future<Object> create() async {
    return await NetUtil(
            path: 'http://${this.serverPrefix}/'
                'api/newuser?'
                'name=${this.name}&'
                'password=${genPasswordHMAC(rawPassword: this.password, mixed: this.name)}')
        .post();
  }
}

class DeleteTokenUtil {
  String token;
  String serverPrefix;
  DeleteTokenUtil({@required this.token, @required this.serverPrefix});
  Future<dynamic> delete() async {
    return await NetUtil(
            path: 'http://${this.serverPrefix}/api/delete/${this.token}')
        .delete();
  }
}
