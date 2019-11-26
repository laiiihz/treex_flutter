import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/generated/i18n.dart';

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

  final Map<int, IconData> _mapNightModeIcon = {
    0: Icons.brightness_3,
    1: Icons.brightness_high,
    2: Icons.brightness_auto,
  };
  Map<int, Widget> _buildMapNightMode(BuildContext context) {
    return {
      0: Text(S.of(context).on, key: Key('open')),
      1: Text(S.of(context).off, key: Key('close')),
      2: Text(S.of(context).auto, key: Key('auto')),
    };
  }

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
          _buildNightMode(context),
        ],
      ),
    );
  }

  Widget _buildNightMode(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return ListTile(
      leading: Icon(_mapNightModeIcon[getNightModeState(context)]),
      title: Text(S.of(context).night_mode),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _buildMapNightMode(context)[getNightModeState(context)],
        ),
      ),
      trailing: DropdownButton(
        items: [
          DropdownMenuItem(child: Text(S.of(context).on), value: 0),
          DropdownMenuItem(child: Text(S.of(context).off), value: 1),
          DropdownMenuItem(child: Text(S.of(context).auto), value: 2),
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
    );
  }
}
