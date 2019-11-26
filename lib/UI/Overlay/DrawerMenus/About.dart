import 'package:flutter/material.dart';
import 'package:treex_flutter/generated/i18n.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Text('test'),
          ),
          Center(
            child: Text('©Honz Inc.'),
          ),
        ],
      ),
    );
  }
}
