import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';

class FileGridTileWidget extends StatefulWidget {
  FileGridTileWidget({
    Key key,
    @required this.onPressed,
    @required this.fileSystemEntity,
  }) : super(key: key);
  final VoidCallback onPressed;
  final FileSystemEntity fileSystemEntity;
  @override
  State<StatefulWidget> createState() => _FileGridTileState();
}

class _FileGridTileState extends State<FileGridTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: widget.onPressed,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isDirectory(widget.fileSystemEntity)
                  ? Icon(
                      FontAwesomeIcons.solidFolder,
                      size: 40,
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
