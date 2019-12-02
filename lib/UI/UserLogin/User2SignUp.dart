import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/UserLogin/User2SignUpSetPassword.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/BackgroundPage.dart';

class User2SignUpPage extends StatefulWidget {
  User2SignUpPage({
    Key key,
    @required this.userName,
  }) : super(key: key);
  final String userName;
  @override
  State<StatefulWidget> createState() => _User2SignUpState();
}

class _User2SignUpState extends State<User2SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).sign_up),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Card(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white10
                      : Colors.white70,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Center(
                    child: Text(
                      S.of(context).user_agreement,
                      style:
                          TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                    ),
                  ),
                  Center(
                    child: Text(
                        '${S.of(context).user_prefix}${provider.userName}'),
                  ),
                ],
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        User2SignUpSetPasswordPage()),
              );
            },
            child: Text(S.of(context).agree_and_continue),
          ),
        ],
      ),
    );
  }
}
