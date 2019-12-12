import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrGenerateState();
}

class _QrGenerateState extends State<QrGeneratePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRGEN'),
      ),
      body: Container(
        child: QrImage(
          data: 'treex://aweyfawefi@@@@@@@ifauwbheiaheif&&&&&&&',
          foregroundColor: Colors.black,
          backgroundColor: Colors.white54,
        ),
      ),
    );
  }
}
