import 'package:flutter/material.dart';

class SingleSongWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingleSongState();
}

class _SingleSongState extends State<SingleSongWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text('Song'),
      ),
    );
  }
}
