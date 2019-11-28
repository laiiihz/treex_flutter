import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/helpers/FileHelper.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/SingleFileListed.dart';

class NormalFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NormalFilesState();
}

class _NormalFilesState extends State<NormalFilesPage> {
  Directory _nowDir;
  List<FileSystemEntity> _files;
  TapDownDetails _tapDownDetails;
  bool _showFAB = true;
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  //Default stack index 0
  //enter a folder index +1
  int _stackIndex = 0;
  List<FileSystemEntity> _folderStack = [];

  @override
  void initState() {
    super.initState();
    initDir() async {
      var tempDir = await getExternalStorageDirectory();
      tempDir = Directory(tempDir.path + '/others');
      if (!tempDir.existsSync()) {
        tempDir.createSync();
      }
      setState(() {
        _nowDir = tempDir;
        _files = tempDir.listSync();
        _folderStack.insert(0, _nowDir);
      });
    }

    animatedScroll();
    initDir();
  }

  @override
  Widget build(BuildContext context) {
    return _nowDir == null
        ? Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                title: Text(getFileShortName(_nowDir)),
              ),
              floatingActionButton: _showFAB ? _buildFAB(context) : null,
              body: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: _buildFolderStackList(context),
                  ),
                  _files.length == 0
                      ? _buildEmptyDirectory()
                      : _buildListView(),
                ],
              ),
            ),
            onWillPop: willPopFunc,
          );
  }

  Future<bool> willPopFunc() async {
    if (!_showFAB) {
      setState(() {
        _showFAB = true;
      });
      Navigator.of(context).pop();
      return false;
    } else if (_stackIndex > 0) {
      setState(() {
        _stackIndex--;
        _nowDir = _nowDir.parent;
        _files = _nowDir.listSync();
        _folderStack.removeAt(0);
        animatedScroll();
      });
      return false;
    } else {
      return true;
    }
  }

  Widget _buildFAB(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return FloatingActionButton(
          onPressed: () {
            setState(() {
              _showFAB = false;
            });
            Scaffold.of(context).showBottomSheet(
              (BuildContext context) {
                return Material(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          S.of(context).new_folder,
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  _showFAB = true;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(S.of(context).cancel),
                            ),
                            RaisedButton(
                              child: Text(S.of(context).new_folder),
                              onPressed: () {
                                Directory(
                                        '${_nowDir.path}/${_textEditingController.text}/')
                                    .create()
                                    .then((_) {
                                  setState(() {
                                    _files = _nowDir.listSync();
                                    _showFAB = true;
                                  });
                                });

                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              elevation: 5,
            );
          },
          heroTag: 'add_menu',
          child: Icon(Icons.add),
        );
      },
    );
  }

  Widget _buildEmptyDirectory() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.inbox),
            Text('空文件夹'),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return SingleFileListedWidget(
            fileSystemEntity: _files[index],
            onTap: () {
              _stackIndex++;
              if (getFileIsDir(_files[index])) {
                setState(() {
                  _nowDir = _files[index];
                });
                setState(() {
                  _files = _nowDir.listSync();
                });

                setState(() {
                  _folderStack.insert(0, _nowDir);
                  animatedScroll();
                });
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => FileHelperPage()),
                );
              }
            },
            onLongTap: () {
              showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(
                  _tapDownDetails.globalPosition.dx,
                  _tapDownDetails.globalPosition.dy,
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
                items: [
                  PopupMenuItem(
                    child: Text('上传到云盘'),
                    value: 'upload',
                  ),
                  PopupMenuItem(
                    child: Text('删除'),
                    value: 'delete',
                  ),
                ],
              ).then((select) {
                switch (select) {
                  case 'upload':
                    print('upload');
                    break;
                  case 'delete':
                    _files[index].deleteSync();
                    setState(() {
                      _files = _nowDir.listSync();
                    });
                    break;
                }
              });
            },
            onTapDown: (TapDownDetails details) {
              setState(() {
                _tapDownDetails = details;
              });
            },
          );
        },
        itemCount: _files.length,
      ),
    );
  }

  Widget _buildFolderStackList(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: Icon(Icons.arrow_left),
            ),
            Center(
              child: Text(getFileShortName(_folderStack[index])),
            ),
          ],
        );
      },
      itemCount: _folderStack.length,
    );
  }

  Future animatedScroll() async {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.animateTo(-20,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
    });
  }
}
