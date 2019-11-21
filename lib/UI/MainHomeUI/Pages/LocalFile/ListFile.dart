import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';

class ListFileWidget extends StatefulWidget {
  ListFileWidget({
    Key key,
    @required this.onTap,
    @required this.file,
  }) : super(key: key);
  final VoidCallback onTap;
  final FileSystemEntity file;
  @override
  State<StatefulWidget> createState() => _ListFileState();
}

class _ListFileState extends State<ListFileWidget> {
  String _shortPath = '';
  String _realFileType = '';
  String _fileNumber = '0';
  IconData _realFileIcon = Icons.folder_open;
  @override
  void initState() {
    super.initState();
    _shortPath = getFileShortName(widget.file);
    _fileNumber = getUnderFileLength(widget.file).toString();
    setState(() {
      _realFileIcon = getDisplayIcon(_shortPath);
      _realFileType = getDisplayName(_shortPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToFileTypesPage(context, _shortPath);
      },
      child: ListTile(
        leading: Hero(tag: _shortPath, child: Icon(_realFileIcon)),
        title: Text(_realFileType),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Badge(
              showBadge: false,
              badgeContent: Text(
                '', //TODO new file size
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Colors.blue,
              shape: BadgeShape.square,
              borderRadius: 5,
            ),
            Text(_fileNumber),
          ],
        ),
      ),
    );
  }
}
