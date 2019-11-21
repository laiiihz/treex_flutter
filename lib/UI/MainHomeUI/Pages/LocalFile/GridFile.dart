import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';
import 'package:treex_flutter/widget/SingleBlock.dart';

class GridFileWidget extends StatefulWidget {
  GridFileWidget({
    Key key,
    @required this.file,
    @required this.onTap,
  }) : super(key: key);
  final FileSystemEntity file;
  final VoidCallback onTap;
  @override
  State<StatefulWidget> createState() => _GridFileState();
}

class _GridFileState extends State<GridFileWidget> {
  String _shortPath = '';
  String _realFileType = '';
  Color _realColor = Colors.grey;
  IconData _realFileIcon = Icons.folder_open;
  @override
  void initState() {
    super.initState();
    _shortPath = getFileShortName(widget.file);
    setState(() {
      _realFileIcon = getDisplayIcon(_shortPath);
      _realFileType = getDisplayName(_shortPath);
      _realColor = getDisplayColor(_shortPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleBlockWidget(
      icon: _realFileIcon,
      text: _realFileType,
      color: _realColor,
      smallText: true,
      callback: () {
        goToFileTypesPage(context, _shortPath);
      },
    );
  }
}
