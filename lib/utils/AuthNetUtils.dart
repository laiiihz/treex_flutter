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
}

class GetFileList {
  String path;
  String baseUrl;
  String token;
  GetFileList(
      {@required this.path, @required this.baseUrl, @required this.token});
  Future<List<dynamic>> get() async {
    dynamic temp = await AuthUtil(baseUrl: this.baseUrl, token: this.token)
        .get(path: this.path);
    return temp['file'];
  }
}
