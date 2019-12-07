import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';

class FileListTileWidget extends StatefulWidget {
  FileListTileWidget({Key key, @required this.fileSystemEntity})
      : super(key: key);
  final FileSystemEntity fileSystemEntity;
  @override
  State<StatefulWidget> createState() => _FileListTileState();
}

class _FileListTileState extends State<FileListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      closeOnScroll: true,
      actions: <Widget>[
        IconSlideAction(
          icon: Icons.cloud_upload,
          color: Colors.green,
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: Icons.delete,
          onTap: () {},
          closeOnTap: true,
          color: Colors.red,
        ),
      ],
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: isDirectory(widget.fileSystemEntity)?Icon(Icons.folder):Icon(Icons.note),
          title: Text(getFileShortPath(widget.fileSystemEntity)),
          subtitle: Text(
              '${_buildSubFileLength()}${fileCreateTimeFormat(widget.fileSystemEntity)}'),
        ),
      ),
    );
  }

  String _buildSubFileLength() {
    if (isDirectory(widget.fileSystemEntity)) {
      int temp = getSubFileLength(widget.fileSystemEntity);
      if (temp == 0)
        return '';
      else {
        return '$temp\t|\t';
      }
    } else
      return '';
  }
}