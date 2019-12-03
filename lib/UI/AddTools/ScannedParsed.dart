import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  void initState() {
    super.initState();
    launch(widget.text.toLowerCase()).then((_) {});
  }

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
