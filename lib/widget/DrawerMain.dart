import 'package:flutter/material.dart';
import 'package:treex_flutter/ColorSchemes.dart';

class DrawerMainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMainWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: tealBackground,
            ),
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
          InkWell(
            child: ListTile(
              title: Text('test'),
            ),
            onTap: (){},
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
