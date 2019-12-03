import 'package:flutter/material.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFile.dart';
import 'package:treex_flutter/generated/i18n.dart';

class CloudFilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudFileState();
}

class _CloudFileState extends State<CloudFilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          height: 50,
          duration: Duration(milliseconds: 500),
          child: Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {}, child: Text(S.of(context).share_folder)),
            ],
          ),
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Color(0xff333333)
                : yellowBackgroundDark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Color(0xff666666)
                        : yellowBackgroundDark,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
