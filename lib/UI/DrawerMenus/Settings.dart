import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  int getNightModeState(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    if (provider.autoNightMode)
      return 2;
    else if (provider.nightModeOn)
      return 0;
    else
      return 1;
  }

  final Map<int, Widget> nightMode = {
    0: Text('开启', key: Key('open')),
    1: Text('关闭', key: Key('close')),
    2: Text('自动', key: Key('auto')),
  };

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.brightness_auto),
            title: Text('夜间模式'),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: nightMode[getNightModeState(context)],
              ),
            ),
            trailing: DropdownButton(
              items: [
                DropdownMenuItem(child: Text('开启'), value: 0),
                DropdownMenuItem(child: Text('关闭'), value: 1),
                DropdownMenuItem(child: Text('自动'), value: 2),
              ],
              onChanged: (value) {
                switch (value) {
                  case 0:
                    provider.changeNightModeState(true);
                    provider.changeAutoNightModeState(false);
                    break;
                  case 1:
                    provider.changeNightModeState(false);
                    provider.changeAutoNightModeState(false);
                    break;
                  case 2:
                    provider.changeNightModeState(false);
                    provider.changeAutoNightModeState(true);
                    break;
                }
              },
              value: getNightModeState(context),
              underline: SizedBox(
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
