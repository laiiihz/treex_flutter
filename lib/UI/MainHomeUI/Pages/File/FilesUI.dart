import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/File/OneTypeDirectory.dart';
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
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: <Widget>[
              SingleBlockWidget(
                icon: FontAwesomeIcons.fileAlt,
                text: 'Document',
                color: blueBackgroundDark,
                smallText: true,
                callback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => OneTypeDirectoryPage(
                        color: blueBackgroundDark,
                        title: 'Document',
                      ),
                    ),
                  );
                },
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.music,
                text: 'Music',
                color: Colors.deepOrange,
                smallText: true,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.code,
                text: 'Codes',
                color: Colors.blueGrey,
                smallText: true,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.video,
                text: 'Video',
                color: Colors.lightGreen,
                smallText: true,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.image,
                text: 'Image',
                color: Colors.green,
                smallText: true,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.fileArchive,
                text: 'Archive',
                color: Colors.brown,
                smallText: true,
              ),
              SingleBlockWidget(
                icon: FontAwesomeIcons.android,
                text: 'Apk',
                color: Colors.lightGreenAccent,
                smallText: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
