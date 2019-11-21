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
  String _deviceInfos = '';

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
        _deviceInfos += _androidDeviceInfo.brand + '\n';
        _deviceInfos += _androidDeviceInfo.board + '\n';
        _deviceInfos += _androidDeviceInfo.device + '\n';
        _deviceInfos += _androidDeviceInfo.display + '\n';
        _deviceInfos += _androidDeviceInfo.fingerprint + '\n';
        _deviceInfos += _androidDeviceInfo.manufacturer + '\n';
        _deviceInfos += _androidDeviceInfo.hardware + '\n';
        _deviceInfos += _androidDeviceInfo.isPhysicalDevice.toString() + '\n';
        _deviceInfos += _androidDeviceInfo.id + '\n';
        _deviceInfos += _androidDeviceInfo.model + '\n';
        _deviceInfos += _androidDeviceInfo.product + '\n';
        _deviceInfos += _androidDeviceInfo.tags + '\n';
        _deviceInfos += _androidDeviceInfo.version.securityPatch + '\n';
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
            child: Text(_deviceInfos),
          ),
        ],
      ),
    );
  }
}
