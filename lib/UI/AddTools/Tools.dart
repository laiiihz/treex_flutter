import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/AddTools/QrScanView.dart';
import 'package:intl/intl.dart';

class ToolsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToolsState();
}

class _ToolsState extends State<ToolsPage> {
  String _displayDate = '';
  Timer _timer;
  @override
  void initState() {
    super.initState();
    setState(() {
      _displayDate = DateFormat('hh:mm:ss').format(DateTime.now());
    });
    _timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      setState(() {
        _displayDate = DateFormat('hh:mm:ss').format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: Text(
            _displayDate,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 50),
        Row(
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
        )
      ],
    );
  }
}
