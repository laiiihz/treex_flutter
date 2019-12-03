import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/utils/NetUtil.dart';

class User2SignUpSetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _User2SignUpSetPasswordState();
}

class _User2SignUpSetPasswordState extends State<User2SignUpSetPasswordPage> {
  TextEditingController _passwordEditController = TextEditingController();
  TextEditingController _passwordReEditController = TextEditingController();
  bool _inputErr = false;
  bool _secondInputErr = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _fabCouldGoNext()
            ? () {
                CreateANewUserUtil(
                  name: provider.userName,
                  password: _passwordEditController.text,
                  serverPrefix: '10.27.16.66:8080',
                ).create();
              }
            : null,
        backgroundColor: _fabCouldGoNext() ? null : Colors.grey,
        label: Text(S.of(context).create),
      ),
      appBar: AppBar(
        title: Text(S.of(context).create_a_account),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text(provider.userName),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _inputErr = value.length == 0;
                  _secondInputErr = _passwordReEditController.text != value;
                });
              },
              controller: _passwordEditController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: S.of(context).short_password,
                hintText: S.of(context).password,
                errorText:
                    _inputErr ? S.of(context).password_cant_be_empty : null,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _secondInputErr = _passwordEditController.text != value;
                });
              },
              controller: _passwordReEditController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: S.of(context).reenter_your_password,
                hintText: S.of(context).password,
                errorText:
                    _secondInputErr ? S.of(context).password_is_not_same : null,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _fabCouldGoNext() {
    return !_inputErr &&
        !_secondInputErr &&
        _passwordEditController.text.length != 0;
  }
}
