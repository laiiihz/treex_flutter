import 'package:flutter/material.dart';

class ScannedParsedPage extends StatefulWidget {
  ScannedParsedPage({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;
  @override
  State<StatefulWidget> createState() => _ScannedParsedState();
}

class _ScannedParsedState extends State<ScannedParsedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(widget.text),
      ),
    );
  }
}
