import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanViewPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController _qrViewController;
  String _scannedText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _qrViewController.toggleFlash();
        },
        heroTag: 'add_menu',
        child: Icon(FontAwesomeIcons.solidLightbulb),
      ),
      body: QRView(
        onQRViewCreated: (QRViewController controller) {
          this._qrViewController = controller;
          controller.scannedDataStream.listen((data) {
            setState(() {
              _scannedText = data;
            });
          });
        },
        key: qrKey,
      ),
    );
  }
}
