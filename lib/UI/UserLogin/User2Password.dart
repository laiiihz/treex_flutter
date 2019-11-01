import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/HomeStructure.dart';
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
  @override
  Widget build(BuildContext context) {
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
            onPressed:_couldNext? () {
              setState(() {
                _networkOperate = true;
              });
              Future<bool> checkUserAuth() async {
                //TODO User Auth (Auth API)
                await Future.delayed(Duration(seconds: 1), () {});
                return true;
              }

              checkUserAuth().then((passed) {
                setState(() {
                  _networkOperate = false;
                });
                if (passed) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomeStructurePage(),
                    ),
                  );
                }
              });
            }:null,
            backgroundColor: _couldNext?null:Colors.grey,
            label: Text('下一步'),
            heroTag: 'next',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BackgroundPageWidget(),
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
                          TextSpan(text: 'Tree'),
                          TextSpan(
                              text: 'x', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    widget.userName,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  Text(
                    '输入您的密码 ',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),

                  TextField(
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
                      labelText: '密码',
                      errorText: (!_couldNext&&!_firstEnter)?'密码不能为空':null,
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.person,
                        ),
                        onPressed: () {
                          _textEditingController.clear();
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
