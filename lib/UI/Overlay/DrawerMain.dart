import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/About.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/Settings.dart';
import 'package:treex_flutter/dev/Developer.dart';
import 'package:treex_flutter/generated/i18n.dart';

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
                        title: Text(S.of(context).user_settings),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: ListTile(
                        leading: Icon(Icons.add),
                        title: Text(S.of(context).add_user),
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
                        leading: Icon(Icons.sentiment_satisfied),
                        title: Text(S.of(context).about),
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
                        title: Text(S.of(context).share),
                      ),
                      onTap: () {
                        Share.share('https://baidu.com');
                      },
                    ),

                    //TEST ONLY
                    InkWell(
                      child: ListTile(
                        leading: Icon(Icons.developer_mode),
                        title: Text(S.of(context).developer_mode),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => DeveloperPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(S.of(context).log_out),
                color: Colors.red,
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
                  PopupMenuButton<int>(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text(S.of(context).on),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(S.of(context).off),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(S.of(context).auto),
                          value: 2,
                        ),
                      ];
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(S.of(context).night_mode),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          provider.changeNightModeState(true);
                          provider.changeAutoNightModeState(false);
                          break;
                        case 1:
                          provider.changeNightModeState(false);
                          provider.changeAutoNightModeState(false);
                          break;
                        case 2:
                          provider.changeAutoNightModeState(true);
                          break;
                      }
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
                          provider.userName,
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
