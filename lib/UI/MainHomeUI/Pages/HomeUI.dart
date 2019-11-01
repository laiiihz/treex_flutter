import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:treex_flutter/ColorSchemes.dart';

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
            color: tealBackgroundDark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 20,
                color: tealBackgroundDark,
              ),
            ],
          ),
          duration: Duration(
            milliseconds: 500,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              return;
            },
            child: GridView(
              padding: EdgeInsets.all(10),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 20,
                          )
                        ],
                      ),
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Icon(
                        Icons.ac_unit,
                        size: 50,
                      ),
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
