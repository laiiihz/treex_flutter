import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';
import 'package:treex_flutter/UI/Files/helper/PhotoHelper.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/RoundIconButton.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController _playerController;
  double _titleOpacityValue = 0;
  @override
  void initState() {
    super.initState();
    _listScroller.addListener(() {
      if (_listScroller.offset <= 200 && _listScroller.offset >= 0) {
        setState(() {
          _titleOpacityValue = _listScroller.offset / 200;
        });
      }
    });
    if (getFileSuffix(widget.fileSystemEntity) == 'mp4') {
      _playerController =
          VideoPlayerController.file(File(widget.fileSystemEntity.path))
            ..initialize()
            ..addListener(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _listScroller.dispose();
    if (_playerController != null) {
      _playerController.dispose();
    }
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
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: 50,
                ),
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _listScroller,
                children: <Widget>[
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
                      showMIUIConfirmDialog(
                        context: context,
                        child: Text(getFileShortPath(widget.fileSystemEntity)),
                        title: '确认删除该文件?',
                        confirm: widget.delete,
                        confirmString: S.of(context).confirm,
                        cancelString: S.of(context).cancel,
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
          child: Hero(
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.width,
                child: InkWell(
                  child: Ink.image(
                    image: FileImage(widget.fileSystemEntity),
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PhotoHelperPage(file: widget.fileSystemEntity),
                      ),
                    );
                  },
                ),
              ),
            ),
            tag: 'img',
          ),
        );
      case 'log':
      case 'txt':
        var temp = (widget.fileSystemEntity as File).readAsStringSync();
        return Text(temp);
        break;
      case 'mp4':
        return _playerController.value.initialized
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: _playerController.value.aspectRatio,
                    child: VideoPlayer(_playerController),
                  ),
                  RaisedButton(onPressed: () {
                    _playerController.play();
                  }),
                ],
              )
            : Container();

        break;
      default:
        return SizedBox(
          height: 50,
        );
    }
  }
}
