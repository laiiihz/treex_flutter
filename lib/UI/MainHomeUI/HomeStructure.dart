import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:screenshot/screenshot.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/UI/AddTools/Tools.dart';
import 'package:treex_flutter/UI/Files/cloud/CloudFiles.dart';
import 'package:treex_flutter/UI/Files/local/LocalFiles.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/Account/Account.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/HomeUI.dart';
import 'package:treex_flutter/UI/MainHomeUI/SearchPage.dart';
import 'package:treex_flutter/generated/i18n.dart';

class HomeStructurePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeStructureState();
}

class _HomeStructureState extends State<HomeStructurePage> {
  ScreenshotController _screenshotController = ScreenshotController();
  PageController _pageController = PageController(initialPage: 0);
  int _bottomBarCurrentIndex = 0;

  Color _appBarColor = tealBackgroundDark;

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
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
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
              _appBarColor = Colors.blue;
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
    return FloatingActionButton(
      heroTag: 'add_menu',
      child: Icon(Icons.add),
      onPressed: () {
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
      },
    );
  }

  Widget _buildAnimateColoredAppBar(BuildContext context) {
    return PreferredSize(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Color(0xff333333)
              : Colors.blue,
        ),
        child: AppBar(
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _textTile,
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
          centerTitle: true,
        ),
        duration: Duration(milliseconds: 500),
      ),
      preferredSize: Size.fromHeight(60),
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
