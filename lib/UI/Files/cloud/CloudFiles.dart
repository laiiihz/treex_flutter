import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/Files/FilesStructure.dart';
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
  List<dynamic> _displayFiles = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<AppProvider>(context);
      provider.setCloudPath('.');
      getFiles('.').then((value) {
        setState(() {
          _displayFiles = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
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
      child: ListView.builder(
        padding: EdgeInsets.only(top: 40),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                  getFiles('.').then((value) {
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
        itemCount: _displayFiles == null ? 0 : _displayFiles.length,
      ),
    );
  }

  Future<dynamic> getFiles(String path) async {
    final provider = Provider.of<AppProvider>(context);
    return await GetFileList(
            baseUrl: provider.serverPrefix, token: provider.token)
        .get(path);
  }
}
