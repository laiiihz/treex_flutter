import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/UserLogin/UserNameIntro.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'next',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => UserNameIntroPage()),
          );
        },
        label: Text('登录/注册'),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundPageWidget(),
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
                      TextSpan(text: 'Tree'),
                      TextSpan(text: 'x', style: TextStyle(color: Colors.red)),
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
