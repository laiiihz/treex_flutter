import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/UserLogin/User2Password.dart';
import 'package:treex_flutter/UI/UserLogin/User2SignUp.dart';
import 'package:treex_flutter/utils/NetUtil.dart';
import 'package:treex_flutter/widget/BackgroundPage.dart';

class UserNameIntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserNameIntroState();
}

class _UserNameIntroState extends State<UserNameIntroPage> {
  TextEditingController _textEditingController = TextEditingController();
  bool _networkOperate = false;
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
            backgroundColor: _couldNext ? null : Colors.grey,
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
                    Future<bool> haveUser() async {
                      //TODO Have user (have user API)
                      await Future.delayed(Duration(seconds: 1), () {});
                      return true;
                    }

                    haveUser().then((haveUser) {
                      setState(() {
                        _networkOperate = false;
                      });
                      if (haveUser) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                User2PasswordPage(
                              userName: _textEditingController.text,
                            ),
                          ),
                        );
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => User2SignUpPage(
                              userName: _textEditingController.text,
                            ),
                          ),
                        );
                      }
                    });
                  }
                : null,
            label: Text('下一步'),
            heroTag: 'next',
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          BackgroundPageWidget(),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white30,
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
                      '登录或注册 ',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    TextField(
                      controller: _textEditingController,
                      autofocus: true,
                      onSubmitted: (text){
                        print('test');
                      },
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
                        labelText: '用户名',
                        helperText: '若无账户将创建账户',
                        errorText:
                            !_couldNext && !_firstEnter ? '用户名不能为空' : null,
                        helperStyle: TextStyle(color: Colors.white),
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.person,
                          ),
                          onPressed: () {
                            setState(() {
                              _couldNext = false;
                            });
                            _textEditingController.clear();
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
