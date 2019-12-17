import 'dart:io';

import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  //GLOBAL NAME
  String _userName = '';
  get userName => _userName;
  setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  String _token = '';
  get token => _token;
  setToken(String s) {
    _token = s;
    notifyListeners();
  }

  String _serverPrefix = 'http://127.0.0.1:8080';
  get serverPrefix => _serverPrefix;
  setIPAndPort(String prefix) {
    _serverPrefix = prefix;
    notifyListeners();
  }

  FileSystemEntity _nowDirectory = Directory('/');
  get nowDirectory => _nowDirectory;
  setNowDirectory(FileSystemEntity fileSystemEntity) {
    _nowDirectory = fileSystemEntity;
    notifyListeners();
  }

  String _cloudPath = '.';
  get cloudPath => _cloudPath;
  setCloudPath(String path) {
    _cloudPath = path;
    notifyListeners();
  }

  String _phone = '';
  String _email = '';
  get phone => _phone;
  get email => _email;
  setPhone(String number) {
    _phone = number;
    notifyListeners();
  }

  setEmail(String mail) {
    _email = mail;
    notifyListeners();
  }
}
