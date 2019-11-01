import 'package:flutter/material.dart';

class BackgroundPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/mountain.webp',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
    );
  }
}
