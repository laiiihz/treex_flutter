import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/AddTools/QrScanView.dart';
import 'package:treex_flutter/widget/SingleBlock.dart';

class HomeUIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUIPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          child: FlareActor(
            'assets/treex-brand.flr',
            fit: BoxFit.fitHeight,
            animation: 'brand',
          ),
        ),
        Expanded(
          child: GridView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(10),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: <Widget>[
              SingleBlockWidget(
                icon: FontAwesomeIcons.qrcode,
                text: '扫一扫',
                color: Colors.blueGrey,
                callback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => QrScanViewPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
