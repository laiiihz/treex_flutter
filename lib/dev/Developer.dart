import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_flutter/UI/AddTools/QrGenerate.dart';
import 'package:treex_flutter/dev/DevFileSearch.dart';
import 'package:treex_flutter/widget/TransparentPageRoute.dart';

class DeveloperPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeveloperState();
}

class _DeveloperState extends State<DeveloperPage> {
  String _token = '';
  DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo _androidDeviceInfo;
  String _deviceInfos = '';
  File _image;
  double _progress;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            TransparentPageRoute(
                builder: (BuildContext context) =>
                    RaisedButton(onPressed: () {})),
          );
        },
        child: Icon(Icons.developer_mode),
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: <Widget>[
          MIUIButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DevFileSearchPage()));
            },
          ),
          RaisedButton.icon(
            icon: Icon(FontAwesomeIcons.qrcode),
            label: Text('QRCODE'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => QrGeneratePage()),
              );
            },
          ),
          RaisedButton(
            onPressed: () {
              showMIUIDialog(
                context: context,
                dyOffset: 0.9,
                label: 'test',
                content: Container(
                  height: 700,
                  child: MaterialButton(onPressed: () {
                    showMIUIDialog(
                      context: context,
                      dyOffset: 0.9,
                      label: 'test',
                      content: Container(
                        height: 600,
                        child: MaterialButton(onPressed: () {}),
                      ),
                    );
                  }),
                ),
              );
            },
            child: Text('TEST MULTI DIALOG'),
          ),
          LinearProgressIndicator(
            value: _progress == null ? null : _progress,
          ),
          RaisedButton(
            onPressed: () {
              ImagePicker.pickImage(source: ImageSource.gallery).then((pic) {
                setState(() {
                  _image = pic;
                });
                Dio dio = new Dio();
                Future<FormData> setData() async {
                  return FormData.fromMap({
                    'image': await MultipartFile.fromFile(pic.path,
                        filename: '1.jpg'),
                  });
                }

                setData().then((data) {
                  dio.post('http://10.27.16.66:8080/upload', data: data,
                      onSendProgress: (sent, all) {
                    setState(() {
                      print('$sent $all');
                      _progress = (sent / all);
                    });
                  }).then((response) {
                    print(response);
                  });
                });
              });
            },
            child: Text('test upload'),
          ),
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
