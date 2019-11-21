import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';

class ImageHelperPage extends StatefulWidget {
  ImageHelperPage({Key key, @required this.file}) : super(key: key);
  final FileSystemEntity file;
  @override
  State<StatefulWidget> createState() => _ImageHelperState();
}

class _ImageHelperState extends State<ImageHelperPage> {
  double _dx = 0;
  double _dy = 0;
  double _downDx = 0;
  double _downDy = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            child: Center(
              child: Transform.translate(
                offset: Offset(_dx, _dy),
                child: Hero(
                  tag: widget.file.path,
                  child: Image.file(
                    File(widget.file.path),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            onPanDown: (detail) {
              setState(() {
                _downDx = detail.globalPosition.dx;
                _downDy = detail.globalPosition.dy;
              });
            },
            onPanUpdate: (detail) {
              setState(() {
                _dx = detail.globalPosition.dx - _downDx;
                _dy = detail.globalPosition.dy - _downDy;
              });
            },
          ),
          Container(
            height: 80,
            child: AppBar(
              leading: BackButton(
                color: provider.nightModeOn ? Colors.white : Colors.black,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
