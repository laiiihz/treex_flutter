import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';
import 'package:treex_flutter/generated/i18n.dart';

class FileGridTileWidget extends StatefulWidget {
  FileGridTileWidget({
    Key key,
    @required this.onPressed,
    @required this.fileSystemEntity,
    @required this.delete,
    @required this.upload,
  }) : super(key: key);
  final VoidCallback onPressed;
  final VoidCallback delete;
  final VoidCallback upload;
  final FileSystemEntity fileSystemEntity;

  @override
  State<StatefulWidget> createState() => _FileGridTileState();
}

class _FileGridTileState extends State<FileGridTileWidget> {
  TapDownDetails _detail;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: widget.onPressed,
        onTapDown: (detail) {
          setState(() {
            _detail = detail;
          });
        },
        onLongPress: () {
          showMenu<String>(
            context: context,
            position: RelativeRect.fromLTRB(
              _detail.globalPosition.dx,
              _detail.globalPosition.dy,
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            items: [
              PopupMenuItem(
                child: Text('上传'),
                value: 'upload',
              ),
              PopupMenuItem(
                child: Text('共享'),
                value: 'share',
              ),
              PopupMenuItem(
                child: Text(
                  '删除',
                  style: TextStyle(color: Colors.red),
                ),
                value: 'delete',
              ),
            ],
          ).then((value) {
            switch (value) {
              case 'delete':
                widget.delete();
                break;
              case 'upload':
                widget.upload();
                break;
              case 'share':
                break;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isDirectory(widget.fileSystemEntity)
                  ? Icon(
                      FontAwesomeIcons.solidFolder,
                      size: 40,
                color: Colors.grey,
                    )
                  : Icon(
                      iconStringMap[getFileSuffix(widget.fileSystemEntity)] ??
                          FontAwesomeIcons.solidFile,
                      size: 40,
                    ),
              SizedBox(height: 10),
              Text(
                getFileShortPath(widget.fileSystemEntity),
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
