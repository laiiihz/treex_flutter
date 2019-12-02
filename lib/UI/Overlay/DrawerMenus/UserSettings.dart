import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/generated/i18n.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).user_settings),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(S.of(context).set_an_avatar),
              trailing: Hero(
                tag: 'user_avatar',
                child: CircleAvatar(
                  child: Text(provider.userName[0]),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.details),
              title: Text(S.of(context).user_name),
              trailing: Text(
                provider.userName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
