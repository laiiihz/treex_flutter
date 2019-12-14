import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/generated/i18n.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutState();
}

class _AboutState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    showMIUIDialog(
                      context: context,
                      noPadding: true,
                      content: Container(
                        height: MediaQuery.of(context).size.height - 100,
                        child: LicensePage(),
                      ),
                      label: 'un',
                      dyOffset: 0.9,
                    );
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.code),
                    title: Text(S.of(context).licenses),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text('©Honz Inc.'),
          ),
        ],
      ),
    );
  }
}
