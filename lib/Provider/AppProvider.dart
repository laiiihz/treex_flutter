import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  //GLOBAL NAME
  String _userName = '';
  get userName => _userName;
  setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}
