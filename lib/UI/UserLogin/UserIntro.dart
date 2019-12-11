import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/NetworkSettings.dart';
import 'package:treex_flutter/UI/UserLogin/UserNameIntro.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/BackgroundPage.dart';

class UserIntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserIntroState();
}

class _UserIntroState extends State<UserIntroPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: 'next',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => UserNameIntroPage()),
              );
            },
            label: Text(S.of(context).sign_up_sign_in),
          ),
          MaterialButton(
            child: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => NetworkSettingsPage()),
              );
            },
            height: 50,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BackgroundPageWidget(),
          buildDarkOverlay(context),
          Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Hero(
                tag: 'title',
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 60,
                    ),
                    children: [
                      TextSpan(text: S.of(context).tree),
                      TextSpan(
                          text: S.of(context).x,
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
