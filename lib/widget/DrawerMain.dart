import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/DrawerMenus/About.dart';

class DrawerMainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMainWidget> {
  double _userHeight = 0;
  bool _userOpen = false;
  bool _hideMoreUser = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
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
                  _userOpen = !_userOpen;
                  setState(() {
                    _userHeight = _userOpen ? 150 : 0;
                  });
                  if (_hideMoreUser) {
                    setState(() {
                      _hideMoreUser = false;
                    });
                  } else {
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() {
                        _hideMoreUser = true;
                      });
                    });
                  }
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
            height: _userHeight,
            child: Offstage(
              offstage: _hideMoreUser,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('用户设置'),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: ListTile(
                        leading: Icon(Icons.add),
                        title: Text('添加用户'),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
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
                    title: Text('About'),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => AboutPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.settings), onPressed: () {}),
              Spacer(),
              Text('夜间模式'),
              Switch(
                value: provider.nightModeOn,
                onChanged: (value) {
                  provider.changeNightModeState(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
