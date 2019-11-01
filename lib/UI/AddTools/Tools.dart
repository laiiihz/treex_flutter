import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class ToolsPage extends StatefulWidget {
  ToolsPage({Key key, @required this.image}) : super(key: key);
  final File image;
  @override
  State<StatefulWidget> createState() => _ToolsState();
}

class _ToolsState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.file(widget.image),
          BackdropFilter(
            filter: prefix0.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment(0, 0.8),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return Material(
                        child: IconButton(
                          icon: Icon(Icons.home),
                          onPressed: () {
                            print('test');
                          },),
                        color: Colors.transparent,
                      );
                    },
                    itemCount: 4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
