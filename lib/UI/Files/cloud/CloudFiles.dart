import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/Files/FilesStructure.dart';
import 'package:treex_flutter/UI/Files/cloud/ShareFiles.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/RoundIconButton.dart';

class CloudFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudFilesState();
}

class _CloudFilesState extends State<CloudFilesPage> {
  @override
  Widget build(BuildContext context) {
    return FilesStructurePage(
        prefix: RoundIconButtonWidget(
          onPress: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ShareFilesPage(),
              ),
            );
          },
          icon: Text(
            S.of(context).shared,
            style: TextStyle(color: Colors.white),
          ),
        ),
        pathList: Container(),
        suffix: Container(),
        child: Container());
  }
}
