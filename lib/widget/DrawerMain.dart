import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/DrawerMenus/About.dart';
import 'package:treex_flutter/UI/DrawerMenus/Settings.dart';

class DrawerMainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMainWidget> {
  bool _userSettingsIsOpen = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Drawer(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AnimatedContainer(
                height: _userSettingsIsOpen ? 180 : 60,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    InkWell(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('用户设置'),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: ListTile(
                        leading: Icon(Icons.add),
                        title: Text('添加用户'),
                      ),
                      onTap: () {},
                    ),
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
                    InkWell(
                      child: ListTile(
                        leading: Icon(Icons.share),
                        title: Text('Share'),
                      ),
                      onTap: () {
                        Share.share('test');
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SettingsPage()),
                        );
                      }),
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DrawerHeader(
                margin: EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
                  color: provider.nightModeOn
                      ? tealBackgroundDark
                      : tealBackground,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _userSettingsIsOpen = !_userSettingsIsOpen;
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
              LinearProgressIndicator(
                value: 0.4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
