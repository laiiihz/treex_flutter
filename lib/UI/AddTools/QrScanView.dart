import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'ScannedParsed.dart';

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
      appBar: AppBar(
        title: Text('扫一扫'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _qrViewController.toggleFlash();
        },
        heroTag: 'add_menu',
        child: Icon(FontAwesomeIcons.solidLightbulb),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: QRView(
                  onQRViewCreated: (QRViewController controller) {
                    this._qrViewController = controller;
                    controller.scannedDataStream.listen((data) {
                      setState(() {
                        _scannedText = data;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ScannedParsedPage(
                            text: _scannedText,
                          ),
                        ),
                      );
                    });
                  },
                  key: qrKey,
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              height: 250,
              width: 250,
              color: Colors.white12,
            ),
          ),
        ],
      ),
    );
  }
}
