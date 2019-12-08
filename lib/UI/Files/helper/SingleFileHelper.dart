import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/RoundIconButton.dart';

class SingleFileHelperPage extends StatefulWidget {
  SingleFileHelperPage({
    Key key,
    @required this.fileSystemEntity,
    @required this.delete,
  }) : super(key: key);
  final FileSystemEntity fileSystemEntity;
  final VoidCallback delete;
  @override
  State<StatefulWidget> createState() => _SingleFileHelperState();
}

class _SingleFileHelperState extends State<SingleFileHelperPage> {
  ScrollController _listScroller = ScrollController();
  double _titleOpacityValue = 0;
  @override
  void initState() {
    super.initState();
    _listScroller.addListener(() {
      if (_listScroller.offset <= 300 && _listScroller.offset >= 100) {
        setState(() {
          _titleOpacityValue = (_listScroller.offset - 100) / 200;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Opacity(
            opacity: _titleOpacityValue,
            child: Text(getFileShortPath(widget.fileSystemEntity)),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                controller: _listScroller,
                children: <Widget>[
                  SizedBox(height: 100),
                  Icon(
                    iconStringMap[getFileSuffix(widget.fileSystemEntity)] ??
                        FontAwesomeIcons.solidFile,
                    size: 40,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(getFileShortPath(widget.fileSystemEntity)),
                  ),
                  SizedBox(height: 50),
                  ListTile(
                    title: Text(S.of(context).create_time),
                    leading: Icon(Icons.grade),
                    trailing:
                        Text(fileCreateTimeFormat(widget.fileSystemEntity)),
                  ),
                  ListTile(
                    title: Text('Changed Time'),
                    leading: Icon(Icons.create),
                    trailing:
                        Text(fileChangedTimeFormat(widget.fileSystemEntity)),
                  ),
                  ListTile(
                    title: Text('Accessed Time'),
                    leading: Icon(Icons.check_circle),
                    trailing:
                        Text(fileAccessedTimeFormat(widget.fileSystemEntity)),
                  ),
                  ListTile(
                    title: Text(S.of(context).mode),
                    leading: Icon(Icons.category),
                    trailing: Text(
                        FileStat.statSync(widget.fileSystemEntity.path)
                            .modeString()),
                  ),
                  ListTile(
                    title: Text(S.of(context).file_type),
                    leading: Icon(Icons.label),
                    trailing: Text(getFileSuffix(widget.fileSystemEntity)),
                  ),
                  ListTile(
                    title: Text(S.of(context).length),
                    leading: Icon(Icons.category),
                    trailing: Text(
                        widget.fileSystemEntity.statSync().size.toString() +
                            'B'),
                  ),
                  ListTile(
                    title: Text(S.of(context).path),
                    leading: Icon(Icons.category),
                    subtitle: Text(widget.fileSystemEntity.path),
                  ),
                  _buildFilePreview(
                      context, getFileSuffix(widget.fileSystemEntity)),
                  SizedBox(height: 200),
                ],
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Color(0xff333333)
                        : Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, -5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundIconButtonWidget(
                    icon: Icon(Icons.cloud_upload),
                    onPress: () {},
                  ),
                  SizedBox(width: 20),
                  RoundIconButtonWidget(
                    icon: Icon(Icons.delete),
                    onPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Material(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 20),
                                Text(
                                  '确认删除文件?',
                                  style: TextStyle(fontSize: 30),
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(S.of(context).cancel)),
                                    RaisedButton(
                                      color: Colors.red,
                                      onPressed: widget.delete,
                                      child: Text(S.of(context).confirm),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildFilePreview(BuildContext context, String fileType) {
    switch (fileType) {
      case 'jpg':
      case 'webp':
      case 'png':
        return Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.width,
            child: Image.file(
              widget.fileSystemEntity,
              fit: BoxFit.cover,
            ),
          ),
        );
      default:
        return SizedBox(
          height: 50,
        );
    }
  }
}
