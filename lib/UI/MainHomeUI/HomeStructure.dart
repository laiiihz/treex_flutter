import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/AddTools/Tools.dart';
import 'package:treex_flutter/UI/Files/cloud/CloudFiles.dart';
import 'package:treex_flutter/UI/Files/local/LocalFiles.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/Account/Account.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/HomeUI.dart';
import 'package:treex_flutter/UI/MainHomeUI/SearchPage.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/utils/AuthNetUtils.dart';

class HomeStructurePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeStructureState();
}

class _HomeStructureState extends State<HomeStructurePage> {
  ScreenshotController _screenshotController = ScreenshotController();
  PageController _pageController = PageController(initialPage: 0);
  int _bottomBarCurrentIndex = 0;
  TextEditingController _newFolderTextController = TextEditingController();
  TextEditingController _cloudNewFolderTextController = TextEditingController();

  Widget _textTile;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _textTile = Text(S.of(context).home, key: Key('defalt'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        appBar: _buildAnimateColoredAppBar(context),
        floatingActionButton:
            _bottomBarCurrentIndex == 3 ? null : _buildFAB(context),
        floatingActionButtonLocation: _bottomBarCurrentIndex == 0
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: _buildBottomNavBar(context),
        body: _buildPages(context),
      ),
    );
  }

  //BUILD FUNCTIONS
  Widget _buildPages(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return HomeUIPage();
            break;
          case 1:
            return CloudFilesPage();
            break;
          case 2:
            return LocalFilesPage();
            break;
          case 3:
            return AccountPage();
          default:
            return HomeUIPage();
            break;
        }
      },
      itemCount: 4,
    );
  }

  List<BottomNavigationBarItem> _buildNavBarItems(BuildContext context) {
    return [
      _buildSingleBottomNaviItem(
          context, Icons.home, OMIcons.home, 0, S.of(context).home),
      _buildSingleBottomNaviItem(
          context, Icons.cloud, OMIcons.cloud, 1, S.of(context).cloud_files),
      _buildSingleBottomNaviItem(
          context, Icons.folder, OMIcons.folder, 2, S.of(context).local_files),
      _buildSingleBottomNaviItem(
          context, Icons.person, OMIcons.person, 3, S.of(context).me),
    ];
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            setState(() {
              _textTile = Text(S.of(context).home, key: Key('home'));
            });
            break;
          case 1:
            setState(() {
              _textTile =
                  Text(S.of(context).cloud_files, key: Key('cloudFiles'));
            });
            break;
          case 2:
            setState(() {
              _textTile =
                  Text(S.of(context).local_files, key: Key('localFiles'));
            });
            break;
          case 3:
            setState(() {
              _textTile = Text(S.of(context).me, key: Key('Me'));
            });
        }
        setState(() {
          _bottomBarCurrentIndex = index;
        });

        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      },
      currentIndex: _bottomBarCurrentIndex,
      unselectedItemColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.white54
              : Colors.black54,
      items: _buildNavBarItems(context),
    );
  }

  Widget _buildFAB(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return FloatingActionButton(
      heroTag: 'add_menu',
      child: Icon(Icons.add),
      onPressed: () {
        switch (_bottomBarCurrentIndex) {
          case 0:
            _screenshotController.capture().then((image) {
              Navigator.of(context).push(
                PageRouteBuilder(pageBuilder: (context, animation, animation2) {
                  return FadeTransition(
                    opacity: animation,
                    child: ToolsPage(
                      image: image,
                    ),
                  );
                }),
              );
            });
            break;
          case 1:
            _cloudNewFolderTextController.clear();
            showMIUIConfirmDialog(
              cancelString: S.of(context).cancel,
              confirmString: S.of(context).confirm,
              context: context,
              child: MIUIDialogTextField(
                  textEditingController: _cloudNewFolderTextController,
                  title: '请输入文件夹名称'),
              title: '新建文件夹',
              confirm: () {
                NewFolderCloud(
                  baseUrl: provider.serverPrefix,
                  token: provider.token,
                  path: provider.cloudPath,
                ).create(_cloudNewFolderTextController.text);
                Navigator.of(context).pop();
              },
            );
            break;
          case 2:
            _newFolderTextController.text = '';
            showMIUIConfirmDialog(
              context: context,
              cancelString: S.of(context).cancel,
              confirmString: S.of(context).confirm,
              child: MIUIDialogTextField(
                title: '请输入文件夹名称',
                textEditingController: _newFolderTextController,
              ),
              title: S.of(context).new_folder,
              confirm: () {
                FileSystemEntity file = provider.nowDirectory;
                Directory('${file.path}/${_newFolderTextController.text}/')
                    .createSync();
                Navigator.of(context).pop();
              },
            );
            break;
        }
      },
    );
  }

  Widget _buildAnimateColoredAppBar(BuildContext context) {
    return AppBar(
      elevation: _bottomBarCurrentIndex == 3 ? 0 : null,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchPage());
            },
          );
        },
      ),
      title: _textTile,
      centerTitle: true,
    );
  }

  BottomNavigationBarItem _buildSingleBottomNaviItem(BuildContext context,
      IconData icon, IconData iconOutline, int index, String name) {
    return BottomNavigationBarItem(
      icon: AnimatedCrossFade(
        firstChild: Icon(icon),
        secondChild: Icon(iconOutline),
        crossFadeState: _bottomBarCurrentIndex == index
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 400),
      ),
      title: Text(name),
    );
  }
}
