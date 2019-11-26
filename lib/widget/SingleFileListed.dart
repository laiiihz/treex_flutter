import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';

class SingleFileListedWidget extends StatefulWidget {
  SingleFileListedWidget({
    Key key,
    @required this.fileSystemEntity,
    @required this.onTap,
  }) : super();
  final FileSystemEntity fileSystemEntity;
  final VoidCallback onTap;
  @override
  State<StatefulWidget> createState() => _SingleFileListedState();
}

class _SingleFileListedState extends State<SingleFileListedWidget> {
  TapDownDetails _tapDownDetails;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onTapDown: (detail) {
        setState(() {
          _tapDownDetails = detail;
        });
      },
      onLongPress: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            _tapDownDetails.globalPosition.dx,
            _tapDownDetails.globalPosition.dy,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          items: [
            PopupMenuItem(child: Text('上传到云盘')),
            PopupMenuItem(child: Text('删除')),
          ],
        );
      },
      child: ListTile(
        leading: Icon(getFileOrDirIcon(widget.fileSystemEntity)),
        title: Text(getFileShortName(widget.fileSystemEntity)),
      ),
    );
  }
}
