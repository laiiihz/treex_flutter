import 'package:flutter/material.dart';
import 'package:treex_flutter/generated/i18n.dart';

class NetworkSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetworkSettingsState();
}

class _NetworkSettingsState extends State<NetworkSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).network_settings),
      ),
    );
  }
}