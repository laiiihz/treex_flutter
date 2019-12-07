import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/UI/Files/FileListTile.dart';
import 'package:treex_flutter/UI/Files/FilesStructure.dart';
import 'package:treex_flutter/widget/RoundIconButton.dart';

class LocalFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocalFilesState();
}

class _LocalFilesState extends State<LocalFilesPage> {
  bool _showViewList = true;
  FileSystemEntity _rootDirectory;
  FileSystemEntity _nowDirectory;
  List<FileSystemEntity> _nowDirectories;
  @override
  void initState() {
    super.initState();
    initFiles() async {
      FileSystemEntity fileSystemEntity = await getExternalStorageDirectory();
      setState(() {
        _rootDirectory = fileSystemEntity.parent.parent.parent.parent;
        _nowDirectory = fileSystemEntity.parent.parent.parent.parent;
      });
    }

    initFiles().then((_) {
      setState(() {
        _nowDirectories = Directory(_nowDirectory.path).listSync();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FilesStructurePage(
      prefix: SizedBox(width: 10),
      suffix: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
        borderOnForeground: true,
        child: RoundIconButtonWidget(
          onPress: () {
            setState(() {
              _showViewList = !_showViewList;
            });
          },
          icon: AnimatedCrossFade(
            firstChild: Icon(Icons.view_list),
            secondChild: Icon(Icons.view_module),
            crossFadeState: _showViewList
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 400),
          ),
        ),
      ),
      pathList: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 40,
            child: Center(
              child: Text('test'),
            ),
          );
        },
      ),
      child: AnimatedSwitcher(
        child: _showViewList ? _buildList(context) : _buildGrid(context),
        duration: Duration(milliseconds: 400),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 40),
      itemBuilder: (BuildContext context, int index) {
        return FileListTileWidget(
          fileSystemEntity: _nowDirectories[index],
        );
      },
      itemCount: _nowDirectories == null ? 0 : _nowDirectories.length,
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 40),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Text('test'),
        );
      },
      itemCount: _nowDirectories == null ? 0 : _nowDirectories.length,
    );
  }
}
