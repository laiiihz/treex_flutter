import 'package:flutter/material.dart';
import 'package:treex_flutter/ColorSchemes.dart';

class DrawerMainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMainWidget> {
  double _userHeight = 0;
  bool _userOpen = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: 0.4,
          ),
          DrawerHeader(
            decoration: BoxDecoration(
              color: tealBackground,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _userOpen =!_userOpen;
                  setState(() {
                    _userHeight = _userOpen?150:0;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 30,
                    ),
                    Text(
                      'name',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            curve: Curves.easeInOutCubic,
            duration: Duration(milliseconds: 500),
            color: Colors.pink,
            height: _userHeight,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text('test'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('test'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                InkWell(
                  child: ListTile(
                    title: Text('test'),
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
