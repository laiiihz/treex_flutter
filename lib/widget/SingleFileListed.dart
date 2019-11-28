import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';

class SingleFileListedWidget extends StatefulWidget {
  SingleFileListedWidget({
    Key key,
    @required this.fileSystemEntity,
    @required this.onTap,
    @required this.onTapDown,
    @required this.onLongTap,
  }) : super();
  final FileSystemEntity fileSystemEntity;
  final VoidCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureLongPressCallback onLongTap;

  @override
  State<StatefulWidget> createState() => _SingleFileListedState();
}

class _SingleFileListedState extends State<SingleFileListedWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onTapDown:widget.onTapDown,
      onLongPress:widget.onLongTap,
      child: ListTile(
        leading: Icon(getFileOrDirIcon(widget.fileSystemEntity)),
        title: Text(getFileShortName(widget.fileSystemEntity)),
      ),
    );
  }
}
