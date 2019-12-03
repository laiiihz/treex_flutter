import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/NetworkSettings.dart';
import 'package:treex_flutter/generated/i18n.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {

            },
            child: ListTile(
              leading: Icon(Icons.language),
              title: Text(S.of(context).network_settings),
            ),
          ),
        ],
      ),
    );
  }

  //Night Mode UI Function

}
