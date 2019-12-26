import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/AddTools/QrScanView.dart';
import 'package:treex_flutter/widget/SingleBlock.dart';

class HomeUIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUIPage> {
  List<Color> _colors = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      _colors.add(genRandomColor());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: TinderSwapCard(
            totalNum: 10,
            orientation: AmassOrientation.LEFT,
            stackNum: 3,
            swipeEdge: 20.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      _colors[index],
                      _colors[9 + index],
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: GridView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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

Color genRandomColor() {
  int baseColor = 0xff000000;
  int tempRandomNum = 0xffffff - 0x000000;
  int randomNum = baseColor + Random().nextInt(tempRandomNum);
  return Color(randomNum);
}
