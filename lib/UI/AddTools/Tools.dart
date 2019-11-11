import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/AddTools/QrScanView.dart';

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
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white54,
                child: Align(
                  alignment: Alignment(0, 0.8),
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    children: [
                      Padding(padding: EdgeInsets.all(10),child: MaterialButton(
                        color: Colors.green,
                        child: Icon(FontAwesomeIcons.qrcode),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  QrScanViewPage(),
                            ),
                          );
                        },
                      ),),
                    ],
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
