import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/widget/SingleBlock.dart';

class FilesUIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesUIState();
}

class _FilesUIState extends State<FilesUIPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SingleBlockWidget(
                icon: FontAwesomeIcons.fileAlt,
                text: 'Document',
                color: blueBackgroundDark,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.music,
                text: 'Music',
                color: Colors.deepOrange,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.code,
                text: 'Codes',
                color: Colors.blueGrey,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.video,
                text: 'Video',
                color: Colors.lightGreen,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.image,
                text: 'Image',
                color: Colors.green,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.fileArchive,
                text: 'Archive',
                color: Colors.brown,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.android,
                text: 'Apk',
                color: Colors.lightGreenAccent,
              ),
            ],
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ),
      ],
    );
  }
}
