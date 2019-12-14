import 'dart:ui';

import 'package:flutter/material.dart';

class FilesStructurePage extends StatefulWidget {
  FilesStructurePage({
    Key key,
    this.isCloud = false,
    @required this.prefix,
    @required this.pathList,
    @required this.suffix,
    @required this.child,
  }) : super(key: key);
  final bool isCloud;
  final Widget prefix;
  final Widget pathList;
  final Widget suffix;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _FilesStructureState();
}

class _FilesStructureState extends State<FilesStructurePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Color(0xaa333333)
                        : Color(0xaa448AFF),
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.prefix,
                    Expanded(child: widget.pathList),
                    widget.suffix,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
