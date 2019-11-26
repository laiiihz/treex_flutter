import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/helpers/FileHelper.dart';
import 'package:treex_flutter/widget/SingleFileListed.dart';

class NormalFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NormalFilesState();
}

class _NormalFilesState extends State<NormalFilesPage> {
  Directory _nowDir;
  List<FileSystemEntity> _files;
  Widget _buildEmptyDirectory() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.inbox),
            Text('空文件夹'),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return SingleFileListedWidget(
            fileSystemEntity: _files[index],
            onTap: () {
              if (getFileIsDir(_files[index])) {
                setState(() {
                  _nowDir = _files[index];
                });
                setState(() {
                  _files = _nowDir.listSync();
                });
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => FileHelperPage()),
                );
              }
            },
          );
        },
        itemCount: _files.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initDir() async {
      var tempDir = await getExternalStorageDirectory();
      tempDir = Directory(tempDir.path + '/others');
      if (!tempDir.existsSync()) {
        tempDir.createSync();
      }
      setState(() {
        _nowDir = tempDir;
        _files = tempDir.listSync();
      });
    }

    initDir();
  }

  @override
  Widget build(BuildContext context) {
    return _nowDir == null
        ? Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(getFileShortName(_nowDir)),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              heroTag: 'add_menu',
            ),
            body: Column(
              children: <Widget>[
                Container(
                  height: 50,
                ),
                _files.length == 0 ? _buildEmptyDirectory() : _buildListView(),
              ],
            ),
          );
  }
}
