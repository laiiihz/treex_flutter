import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/MainHomeUI/HomeStructure.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/utils/NetUtil.dart';
import 'package:treex_flutter/widget/BackgroundPage.dart';

class User2PasswordPage extends StatefulWidget {
  User2PasswordPage({
    Key key,
    @required this.userName,
  }) : super(key: key);
  final String userName;
  @override
  State<StatefulWidget> createState() => _User2PasswordState();
}

class _User2PasswordState extends State<User2PasswordPage> {
  bool _networkOperate = false;
  TextEditingController _textEditingController = TextEditingController();
  bool _couldNext = false;
  bool _firstEnter = true;
  bool _showPasswd = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back),
            heroTag: 'back',
          ),
          Spacer(),
          FloatingActionButton.extended(
            icon: _networkOperate
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white30,
                  )
                : null,
            onPressed: _couldNext
                ? () {
                    setState(() {
                      _networkOperate = true;
                    });
                    Future<bool> checkUserAuth() async {
                      dynamic json = await LoginUtil(
                        userName: widget.userName,
                        password: _textEditingController.text,
                        serverPrefix: '${provider.serverPrefix}',
                      ).getToken();
                      SharedPreferences shared =
                          await SharedPreferences.getInstance();
                      shared.setString('token', json['token']);
                      print(json['user']['phone']);
                      provider.setEmail(json['user']['email']);
                      provider.setPhone(json['user']['phone']);
                      provider.setToken(json['token']);
                      return true;
                    }

                    checkUserAuth().then((passed) {
                      setState(() {
                        _networkOperate = false;
                      });
                      if (passed) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeStructurePage(),
                          ),
                        );
                      }
                    });
                  }
                : null,
            backgroundColor: _couldNext ? null : Colors.grey,
            label: Text(S.of(context).next),
            heroTag: 'next',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BackgroundPageWidget(),
          buildDarkOverlay(context),
          BackdropFilter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
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
                  Text(
                    widget.userName,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  Text(
                    S.of(context).password,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  TextField(
                    autofocus: true,
                    obscureText: !_showPasswd,
                    controller: _textEditingController,
                    onChanged: (text) {
                      setState(() {
                        _firstEnter = false;
                      });
                      if (text.length == 0) {
                        setState(() {
                          _couldNext = false;
                        });
                      } else {
                        setState(() {
                          _couldNext = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: S.of(context).short_password,
                      errorText: (!_couldNext && !_firstEnter)
                          ? S.of(context).password_cant_be_empty
                          : null,
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.person,
                        ),
                        onPressed: () {
                          _textEditingController.clear();
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_showPasswd
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _showPasswd = !_showPasswd;
                          });
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          ),
        ],
      ),
    );
  }
}
