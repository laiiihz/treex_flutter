import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthUtil {
  String baseUrl; //with port
  String token;
  Dio _dio;
  Response _response;
  AuthUtil({
    @required this.baseUrl,
    @required this.token,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: this.baseUrl,
        headers: {
          'authorization': this.token,
        },
      ),
    );
  }
  Future<dynamic> get({@required String path}) async {
    try {
      _response = await _dio.get(path);
      return _response.data;
    } catch (e) {
      print(e);
      return {'status': 999999, 'message': e.toString()};
    }
  }

  Future<dynamic> delete({@required String path}) async {
    try {
      _response = await _dio.delete(path);
      return _response.data;
    } catch (e) {
      print(e);
      return {'status': 999999, 'message': e.toString()};
    }
  }

  Future<dynamic> put({@required String path}) async {
    try {
      _response = await _dio.put(path);
      return _response.data;
    } catch (e) {
      return {'status': 999999, 'message': e.toString()};
    }
  }
}

class GetFileList {
  String baseUrl;
  String token;
  GetFileList({@required this.baseUrl, @required this.token});
  Future<List<dynamic>> get(String path) async {
    dynamic temp = await AuthUtil(baseUrl: this.baseUrl, token: this.token)
        .get(path: '/api/intro/files?path=$path');
    return temp['file'];
  }
}

class NewFolderCloud {
  String path;
  String baseUrl;
  String token;
  NewFolderCloud({
    @required this.path,
    @required this.baseUrl,
    @required this.token,
  });
  Future<bool> create(String folder) async {
    dynamic temp = await AuthUtil(
      token: this.token,
      baseUrl: this.baseUrl,
    ).put(path: '/api/intro/newFolder?folder=$folder&path=${this.path}');
    return temp['status'] == 200;
  }
}

class DeleteFile {
  String baseUrl;
  String token;
  String path;
  DeleteFile({
    @required this.baseUrl,
    @required this.token,
    @required this.path,
  });
  Future<bool> delete(String fileName) async {
    dynamic temp = await AuthUtil(
      token: this.token,
      baseUrl: this.baseUrl,
    ).delete(path: '/api/intro/deleteFile?path=${this.path}/$fileName');
    return temp['status'] == 200;
  }
}
