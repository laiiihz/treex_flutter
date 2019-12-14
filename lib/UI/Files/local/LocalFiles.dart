import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/Files/local/FileGridTile.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';
import 'package:treex_flutter/UI/Files/FilesStructure.dart';
import 'package:treex_flutter/UI/Files/helper/SingleFileHelper.dart';
import 'package:treex_flutter/UI/Files/local/FileListTile.dart';
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
  ScrollController _pathListController = ScrollController();
  TextEditingController _renameTextEditor = TextEditingController();
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
    return WillPopScope(
        child: FilesStructurePage(
          prefix: SizedBox(width: 10),
          suffix: RoundIconButtonWidget(
            onPress: () {
              setState(() {
                _randomKey = Random().nextDouble().toString();
                _showViewList = !_showViewList;
              });
            },
            icon: AnimatedCrossFade(
              firstChild: Icon(Icons.view_list, color: Colors.white),
              secondChild: Icon(Icons.view_module, color: Colors.white),
              crossFadeState: _showViewList
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 400),
            ),
          ),
          pathList: _dirStack == null
              ? LinearProgressIndicator()
              : ListView.builder(
                  controller: _pathListController,
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        height: 40,
                        child: Center(
                          child: Text(getFileShortPath(_dirStack[index])),
                        ),
                      );
                    }
                    return Container(
                      height: 40,
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('•'),
                          Text(getFileShortPath(_dirStack[index])),
                        ],
                      )),
                    );
                  },
                  itemCount: _dirStack.length,
                ),
          child: AnimatedSwitcher(
            child: _nowDirectories == null
                ? Center(child: CircularProgressIndicator())
                : _nowDirectories.length == 0
                    ? _buildCenterEmptyIcon(context)
                    : RefreshIndicator(
                        child: _showViewList
                            ? _buildList(context)
                            : _buildGrid(context),
                        key: Key('$_randomKey list'),
                        onRefresh: () async {
                          await updateFiles();

                          await Future.delayed(Duration(milliseconds: 500), () {
                            setState(() {
                              _randomKey = Random().nextDouble().toString();
                            });
                          });
                        }),
            duration: Duration(milliseconds: 400),
          ),
        ),
        onWillPop: () async {
          _nowDirectory = _nowDirectory.parent;
          _nowDirectories = (_nowDirectory as Directory).listSync();
          _dirStack.removeAt(0);
          _pathListController.animateTo(
            -30,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInCubic,
          );
          updateFiles();
          print('pop');
          return false;
        });
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.only(top: 40),
      itemBuilder: (BuildContext context, int index) {
        return FileListTileWidget(
          onPress: () {
            _pathListController.animateTo(
              -30,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInCubic,
            );
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
            onDelete(
              fileSystemEntity: _nowDirectories[index],
              context: context,
            );
          },
          rename: () {
            _renameTextEditor.text = getFileShortPath(_nowDirectories[index]);
            showMIUIConfirmDialog(
              context: context,
              child: MIUIDialogTextField(
                textEditingController: _renameTextEditor,
                title: getFileShortPath(
                  _nowDirectories[index],
                ),
              ),
              title: '重命名该文件',
              confirm: () {
                _nowDirectories[index].renameSync('/storage/emulated/0/123');
                updateFiles();
              },
              cancelString: S.of(context).cancel,
              confirmString: S.of(context).confirm,
            );
          },
        );
      },
      itemCount: _nowDirectories == null ? 0 : _nowDirectories.length,
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.only(top: 40),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return FileGridTileWidget(
          fileSystemEntity: _nowDirectories[index],
          onPressed: () {
            _dirStack.insert(0, _nowDirectories[index]);
            _pathListController.animateTo(
              -30,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInCubic,
            );
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
          delete: () {
            onDelete(
                fileSystemEntity: _nowDirectories[index], context: context);
          },
          upload: () {},
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
    final provider = Provider.of<AppProvider>(context);
    provider.setNowDirectory(_nowDirectory);
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

  void onDelete({
    @required FileSystemEntity fileSystemEntity,
    @required BuildContext context,
  }) {
    if (isDirectory(fileSystemEntity)) {
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
        },
      );

      countFileSize(fileSystemEntity).then((value) {
        Navigator.of(context).pop();
        setState(() {
          _dialogFileSize = value['file'];
          _dialogDirSize = value['dir'];
        });
        showMIUIConfirmDialog(
            context: context,
            cancelString: S.of(context).cancel,
            confirmString: S.of(context).confirm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('${getFileShortPath(fileSystemEntity)}'),
                Text('文件数:$_dialogFileSize'),
                Text('文件夹数:$_dialogDirSize'),
              ],
            ),
            title: '删除该文件夹?',
            confirm: () {
              deleteFile(fileSystemEntity).then((_) {
                updateFiles();
              });
              Navigator.of(context).pop();
            });
      });
    } else {
      showMIUIConfirmDialog(
        context: context,
        child: Text(getFileShortPath(fileSystemEntity)),
        cancelString: S.of(context).cancel,
        confirmString: S.of(context).confirm,
        title: '删除该文件?',
        confirm: () {
          deleteFile(fileSystemEntity).then((_) {
            updateFiles();
            Navigator.of(context).pop();
          });
        },
      );
    }
  }
}
