import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _nightModeOn = false;
  get nightModeOn => _nightModeOn;
  changeNightModeState(bool nightState) {
    _nightModeOn = nightState;
    notifyListeners();
  }
}
