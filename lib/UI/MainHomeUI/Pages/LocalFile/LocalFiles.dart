import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/widget/SingleFileListTile.dart';

class LocalFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocalFilesState();
}

class _LocalFilesState extends State<LocalFilesPage> {
  FileSystemEntity _fileSystemEntity;
  @override
  void initState() {
    super.initState();
    //_fileSystemEntity = Directory('/');
    Future test()async{
      Directory temp = await getExternalStorageDirectory();
      print(temp.parent.parent.parent.parent);
    }
    test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            height: 100,
            color: Colors.grey,
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SingleFileListTileWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
