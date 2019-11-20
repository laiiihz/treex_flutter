import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeveloperPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeveloperState();
}

class _DeveloperState extends State<DeveloperPage> {
  String _token = '';
  DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo _androidDeviceInfo;
  String _board = '';
  String _brand = '';

  @override
  void initState() {
    super.initState();
    Future<String> getToken() async {
      SharedPreferences shared = await SharedPreferences.getInstance();
      return shared.getString('token');
    }

    Future getDeviceInfo() async {
      _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
      setState(() {
        _board = _androidDeviceInfo.board.toString();
        _brand = _androidDeviceInfo.brand.toString();
      });
    }

    getDeviceInfo();

    getToken().then((tokenValue) {
      setState(() {
        _token = tokenValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dev'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Text(_token),
          ),
          Card(
            child: Row(
              children: <Widget>[Text('board:$_board')],
            ),
          ),
          Card(
            child: Row(
              children: <Widget>[Text('brand:$_brand')],
            ),
          ),
        ],
      ),
    );
  }
}
