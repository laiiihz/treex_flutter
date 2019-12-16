import 'dart:io';

import 'package:flutter/material.dart';

class PhotoHelperPage extends StatefulWidget {
  PhotoHelperPage({Key key, @required this.file}) : super(key: key);
  final FileSystemEntity file;
  @override
  State<StatefulWidget> createState() => _PhotoHelperState();
}

class _PhotoHelperState extends State<PhotoHelperPage> {
  bool _showAppBar = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar ? AppBar() : null,
      body: Center(
        child: Hero(
          tag: 'img',
          child: Material(
            child: InkWell(
              child: Transform.scale(
                scale: 1.0,
                child: Ink.image(
                  image: FileImage(widget.file),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
