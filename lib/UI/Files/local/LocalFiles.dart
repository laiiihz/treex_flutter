import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/UI/Files/FileGridTile.dart';
import 'package:treex_flutter/UI/Files/FileListTile.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';
import 'package:treex_flutter/UI/Files/FilesStructure.dart';
import 'package:treex_flutter/UI/Files/helper/SingleFileHelper.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/RoundIconButton.dart';

class LocalFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocalFilesState();
}

class _LocalFilesState extends State<LocalFilesPage> {
  bool _showViewList = true;
  FileSystemEntity _rootDirectory;
  FileSystemEntity _nowDirectory;
  List<FileSystemEntity> _nowDirectories;
  List<FileSystemEntity> _dirStack = [];
  int _dialogFileSize = 0;
  int _dialogDirSize = 0;
  String _randomKey = 'RANDOMKEY';
  @override
  void initState() {
    super.initState();
    initFiles() async {
      FileSystemEntity fileSystemEntity = await getExternalStorageDirectory();
      setState(() {
        _rootDirectory = fileSystemEntity.parent.parent.parent.parent;
        _nowDirectory = fileSystemEntity.parent.parent.parent.parent;
        _dirStack.insert(0, _nowDirectory);
      });
    }

    initFiles().then((_) {
      updateFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FilesStructurePage(
      prefix: SizedBox(width: 10),
      suffix: RoundIconButtonWidget(
        onPress: () {
          setState(() {
            _showViewList = !_showViewList;
          });
        },
        icon: AnimatedCrossFade(
          firstChild: Icon(Icons.view_list),
          secondChild: Icon(Icons.view_module),
          crossFadeState: _showViewList
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 400),
        ),
      ),
      pathList: _dirStack == null
          ? LinearProgressIndicator()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 40,
                  child: Center(
                    child: Text(getFileShortPath(_dirStack[index])),
                  ),
                );
              },
              itemCount: _dirStack.length,
            ),
      child: AnimatedSwitcher(
        child: _showViewList ? _buildList(context) : _buildGrid(context),
        duration: Duration(milliseconds: 400),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return _nowDirectories == null
        ? Center(child: CircularProgressIndicator())
        : _nowDirectories.length == 0
            ? _buildCenterEmptyIcon(context)
            : ListView.builder(
                key: Key(_randomKey),
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 40),
                itemBuilder: (BuildContext context, int index) {
                  return FileListTileWidget(
                    onPress: () {
                      if (isDirectory(_nowDirectories[index])) {
                        _nowDirectory = _nowDirectories[index];
                        setState(() {
                          _randomKey = Random().nextDouble().toString();
                          _dirStack.insert(0, _nowDirectories[index]);
                        });
                        updateFiles();
                      } else {
                        go2FileHelper(context, _nowDirectories[index]);
                      }
                    },
                    fileSystemEntity: _nowDirectories[index],
                    delete: () {
                      showGeneralDialog(
                          barrierColor: Colors.black26,
                          barrierLabel: 'loading',
                          barrierDismissible: true,
                          transitionDuration: Duration(milliseconds: 400),
                          context: context,
                          pageBuilder: (context, animation, animation2) {
                            return Dialog(
                              child: LinearProgressIndicator(),
                            );
                          });

                      countFileSize(_nowDirectories[index]).then((value) {
                        Navigator.of(context).pop();
                        setState(() {
                          _dialogFileSize = value['file'];
                          _dialogDirSize = value['dir'];
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(isDirectory(_nowDirectories[index])
                                  ? '删除该文件夹?'
                                  : '删除该文件?'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                      '${getFileShortPath(_nowDirectories[index])}'),
                                  Text('文件数:$_dialogFileSize'),
                                  Text('文件夹数:$_dialogDirSize'),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(S.of(context).cancel)),
                                RaisedButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    deleteFile(_nowDirectories[index])
                                        .then((_) {
                                      updateFiles();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(S.of(context).confirm),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  );
                },
                itemCount: _nowDirectories == null ? 0 : _nowDirectories.length,
              );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      key: Key('$_randomKey grid'),
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 40),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return FileGridTileWidget(
          fileSystemEntity: _nowDirectories[index],
          onPressed: () {
            if (isDirectory(_nowDirectories[index])) {
              _nowDirectory = _nowDirectories[index];
              setState(() {
                _randomKey = Random().nextDouble().toString();
              });

              updateFiles();
            } else {
              go2FileHelper(context, _nowDirectories[index]);
            }
          },
        );
      },
      itemCount: _nowDirectories == null ? 0 : _nowDirectories.length,
    );
  }

  Widget _buildCenterEmptyIcon(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.inbox,
            size: 40,
          ),
        ],
      ),
    );
  }

  updateFiles() {
    _nowDirectories = Directory(_nowDirectory.path).listSync();
    _nowDirectories = fileHiddenDisplay(files: _nowDirectories);
    _nowDirectories = fileFilterA2Z(_nowDirectories);
    setState(() {
      _nowDirectories = fileFilterDirOrFile(_nowDirectories);
    });
  }

  go2FileHelper(BuildContext context, FileSystemEntity file) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SingleFileHelperPage(
          fileSystemEntity: file,
          delete: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            file.deleteSync();
            updateFiles();
          },
        ),
      ),
    );
  }
}
