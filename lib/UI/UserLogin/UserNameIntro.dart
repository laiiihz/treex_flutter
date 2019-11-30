import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/UserLogin/User2Password.dart';
import 'package:treex_flutter/UI/UserLogin/User2SignUp.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/utils/NetUtil.dart';
import 'package:treex_flutter/utils/PasswordGen.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    genPasswordHMAC(rawPassword: 'testtest', mixed: 'name');
  }

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
                      Map<String ,dynamic> result =await UserExistUtil(
                          name: _textEditingController.text, serverPrefix: '10.27.16.66:8080')
                          .check();
                      if(result['exist'])return true;
                      else return false;
                    }

                    provider.setUserName(_textEditingController.text);
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
            label: Text(S.of(context).next),
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
                      S.of(context).loginin_on_signup,
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    TextField(
                      controller: _textEditingController,
                      autofocus: true,
                      onSubmitted: (text) {
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
                        labelText: S.of(context).user_name,
                        helperText:
                            S.of(context).create_a_account_if_you_dont_have,
                        errorText: !_couldNext && !_firstEnter
                            ? S.of(context).user_name_cant_empty
                            : null,
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
