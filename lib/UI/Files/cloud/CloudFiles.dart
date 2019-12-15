import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/Files/FilesStructure.dart';
import 'package:treex_flutter/UI/Files/cloud/CloudGridTile.dart';
import 'package:treex_flutter/UI/Files/cloud/CloudListTile.dart';
import 'package:treex_flutter/UI/Files/cloud/ShareFiles.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/utils/AuthNetUtils.dart';
import 'package:treex_flutter/widget/RoundIconButton.dart';

class CloudFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudFilesState();
}

class _CloudFilesState extends State<CloudFilesPage> {
  List<dynamic> _displayFiles;
  bool _showViewList = true;
  String _randomKey = '@';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<AppProvider>(context);
      provider.setCloudPath('.');
      getFileList('.').then((value) {
        setState(() => _displayFiles = value);
      });
    });
  }

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
      suffix: RoundIconButtonWidget(
        onPress: () {
          setState(() => _showViewList = !_showViewList);
          setState(() => _randomKey = Random().nextDouble().toString());
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
      child: AnimatedSwitcher(
        duration: Duration(
          milliseconds: 500,
        ),
        child: RefreshIndicator(
          child: _showViewList ? _buildList(context) : _buildGrid(context),
          key: Key(_randomKey),
          onRefresh: () async {
            List<dynamic> result = await getFileList('.');
            setState(() => _displayFiles = result);
            setState(() => _randomKey = Random().nextDouble().toString());
            return true;
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return (_displayFiles == null)
        ? _buildLoading(context)
        : _displayFiles.length == 0
            ? _buildEmpty(context)
            : ListView.builder(
                padding: EdgeInsets.only(top: 40),
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemBuilder: (BuildContext context, int index) {
                  return CloudListTileWidget(
                    cloudFile: _displayFiles[index],
                    delete: () {
                      showMIUIConfirmDialog(
                        context: context,
                        child: Text(''),
                        title: '删除该文件?',
                        confirm: () {
                          DeleteFile(
                                  baseUrl: provider.serverPrefix,
                                  token: provider.token,
                                  path: provider.cloudPath)
                              .delete('${_displayFiles[index]['name']}');
                          Navigator.of(context).pop();
                          getFileList('.').then((value) {
                            setState(() {
                              _displayFiles = value;
                            });
                          });
                        },
                        confirmString: S.of(context).confirm,
                        cancelString: S.of(context).cancel,
                      );
                    },
                  );
                },
                itemCount: _displayFiles.length,
              );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.only(top: 40),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return CloudGridTileWidget();
      },
      itemCount: _displayFiles.length,
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Icon(
        Icons.inbox,
        size: 40,
      ),
    );
  }

  Future<List<dynamic>> getFileList(String path) async {
    final provider = Provider.of<AppProvider>(context);
    return await GetFileList(
            baseUrl: provider.serverPrefix, token: provider.token)
        .get(path);
  }
}
