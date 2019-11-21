import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/GridFile.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/ListFile.dart';

class LocalFilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocalFileState();
}

class _LocalFileState extends State<LocalFilePage> {
  CrossFadeState _crossFadeStateGrid = CrossFadeState.showFirst;
  FileSystemEntity _presentDirectory;
  List<FileSystemEntity> _presentFiles = [];
  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return GridFileWidget(
          file: _presentFiles[index],
          onTap: () {},
        );
      },
      itemCount: _presentFiles.length,
    );
  }

  Widget _buildList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ListFileWidget(onTap: () {}, file: _presentFiles[index]);
      },
      itemCount: _presentFiles.length,
    );
  }

  Future<FileSystemEntity> initFiles() async {
    List<String> dirs = [
      'pics',
      'music',
      'movies',
      'docs',
      'others',
    ];
    _presentDirectory = await getExternalStorageDirectory();
    for (int i = 0; i < dirs.length; i++) {
      var needCreateDir = Directory('${_presentDirectory.path}/${dirs[i]}');
      if (!needCreateDir.existsSync()) {
        needCreateDir.createSync();
      }
    }
    return _presentDirectory;
  }

  List<FileSystemEntity> getLocalFiles(FileSystemEntity fileSystemEntity) {
    return Directory(fileSystemEntity.path).listSync();
  }

  @override
  void initState() {
    super.initState();
    initFiles().then((presentDir) {
      setState(() {
        _presentFiles = getLocalFiles(presentDir);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: 50,
          decoration: BoxDecoration(color: yellowBackgroundDark),
          child: Row(
            children: <Widget>[
              Spacer(),
              AnimatedCrossFade(
                  firstChild: IconButton(
                      icon: Icon(
                        Icons.view_module,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _crossFadeStateGrid = CrossFadeState.showSecond;
                        });
                      }),
                  secondChild: IconButton(
                      icon: Icon(
                        Icons.view_list,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _crossFadeStateGrid = CrossFadeState.showFirst;
                        });
                      }),
                  crossFadeState: _crossFadeStateGrid,
                  duration: Duration(milliseconds: 500)),
            ],
          ),
        ),
        Expanded(
          child: _crossFadeStateGrid == CrossFadeState.showFirst
              ? _buildGrid()
              : _buildList(),
        ),
      ],
    );
  }
}
