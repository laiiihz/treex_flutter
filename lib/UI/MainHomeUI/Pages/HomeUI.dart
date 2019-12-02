import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/AddTools/QrScanView.dart';
import 'package:treex_flutter/widget/SingleBlock.dart';

class HomeUIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUIPage> {
  double _welcomeTitleHeight = 100.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _welcomeTitleHeight = 200;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Column(
      children: <Widget>[
        AnimatedContainer(
          curve: Curves.easeInOutCubic,
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '欢迎使用Treex',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    child: FlareActor(
                      'assets/treex-brand.flr',
                      fit: BoxFit.fitHeight,
                      animation: 'brand',
                    ),
                    minWidth: 100,
                    textColor: Colors.blue,
                    onPressed: () {
                      setState(() {
                        _welcomeTitleHeight = 0;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          height: _welcomeTitleHeight,
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Color(0xff333333)
                : tealBackgroundDark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 20,
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Color(0xff666666)
                        : tealBackgroundDark,
              ),
            ],
          ),
          duration: Duration(
            milliseconds: 500,
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
              SingleBlockWidget(
                icon: Icons.settings,
                text: 'test',
                color: Colors.indigo,
                callback: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
