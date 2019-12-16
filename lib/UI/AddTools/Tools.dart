import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/AddTools/QrScanView.dart';

class ToolsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToolsState();
}

class _ToolsState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(FontAwesomeIcons.qrcode),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QrScanViewPage(),
              ),
            );
          },
        )
      ],
    );
  }
}
