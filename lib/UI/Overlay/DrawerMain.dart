import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/Provider/GlobalStaticValue.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/About.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/Settings.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/UserSettings.dart';
import 'package:treex_flutter/dev/Developer.dart';
import 'package:treex_flutter/generated/i18n.dart';

class DrawerMainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMainWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? tealBackgroundDark
                      : tealBackground,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserSettingsPage()),
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Hero(
                      tag: 'user_avatar',
                      child: CircleAvatar(
                        maxRadius: 30,
                      ),
                    ),
                    Hero(
                      tag: 'user_name',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          provider.userName,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          LinearProgressIndicator(
            value: 0.4,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
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
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              //TODO logout (delete token from server redis)
            },
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
                          builder: (BuildContext context) => SettingsPage()),
                    );
                  }),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
