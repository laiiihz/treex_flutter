import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {

  //GLOBAL NAME
  String _userName = '';
  get userName => _userName;
  setUserName(String name){
    _userName = name;
    notifyListeners();
  }


  bool _nightModeOn = false;
  get nightModeOn => _nightModeOn;
  changeNightModeState(bool nightState) {
    _nightModeOn = nightState;
    notifyListeners();
  }

  bool _autoNightMode = false;
  get autoNightMode => _autoNightMode;
  changeAutoNightModeState(bool autoState) {
    _autoNightMode = autoState;
    notifyListeners();
  }
}
