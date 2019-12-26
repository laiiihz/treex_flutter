import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';

class DevFileSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DevFileSearchState();
}

class _DevFileSearchState extends State<DevFileSearchPage> {
  String _value = '';
  @override
  void initState() {
    super.initState();
    countAllFile() async {
      Directory dir = await getExternalStorageDirectory();
      Directory temp = dir.parent.parent.parent.parent;
      calculateFiles(temp).then((count) {
        setState(() {
          _value = count.toString();
        });
      });
    }

    countAllFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: MIUIScrollPhysics(),
        children: <Widget>[Text(_value)],
      ),
    );
  }
}

Future<List<FileSystemEntity>> searchFileByString(String name) async {
  return compute(searchFileByStringInside, name);
}

Future<List<FileSystemEntity>> searchFileByStringInside(String name) {}
