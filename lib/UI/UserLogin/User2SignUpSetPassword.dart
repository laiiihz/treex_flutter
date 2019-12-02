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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          CreateANewUserUtil(
                  name: provider.userName,
                  password: _passwordEditController.text,
                  serverPrefix: '10.27.16.66:8080')
              .create();
        },
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
              controller: _passwordEditController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: S.of(context).short_password,
                hintText: S.of(context).password,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _passwordReEditController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: S.of(context).reenter_your_password,
                hintText: S.of(context).password,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
