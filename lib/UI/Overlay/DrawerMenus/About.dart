import 'package:flutter/material.dart';
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LicensePage(),
                      ),
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
