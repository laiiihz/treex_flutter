import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/AddTools/Tools.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/CloudFIle/CloudFile.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/File/FilesUI.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/HomeUI.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFile.dart';
import 'package:treex_flutter/UI/MainHomeUI/SearchPage.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMain.dart';

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
          drawer: DrawerMainWidget(),
          floatingActionButton: _buildFAB(context),
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
            return CloudFilePage();
            break;
          case 2:
            return LocalFilePage();
            break;
          default:
            return HomeUIPage();
            break;
        }
      },
      itemCount: 3,
    );
  }

  List<BottomNavigationBarItem> _buildNavBarItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.yellow,
        ),
        title: Text(S.of(context).home),
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.teal.withOpacity(0.2)
                : tealBackground,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.cloud,
          color: Colors.teal,
        ),
        title: Text(S.of(context).cloud_files),
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.blue.withOpacity(0.2)
                : blueBackground,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.folder,
          color: Colors.blue,
        ),
        title: Text(S.of(context).local_files),
        backgroundColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.yellow.withOpacity(0.2)
                : yellowBackground,
      ),
    ];
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      onTap: (index) {
        switch (index) {
          case 0:
            setState(() {
              _appBarColor = tealBackgroundDark;
              _textTile = Text(S.of(context).home, key: Key('home'));
            });
            break;
          case 1:
            setState(() {
              _appBarColor = blueBackgroundDark;
              _textTile =
                  Text(S.of(context).cloud_files, key: Key('cloudFiles'));
            });
            break;
          case 2:
            setState(() {
              _appBarColor = yellowBackgroundDark;
              _textTile =
                  Text(S.of(context).local_files, key: Key('localFiles'));
            });
            break;
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
      elevation: 0,
      currentIndex: _bottomBarCurrentIndex,
      selectedItemColor:
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
              : _appBarColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 20,
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.transparent
                      : _appBarColor,
            ),
          ],
        ),
        child: AppBar(
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
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: SearchPage());
                  },
                );
              },
            ),
          ],
        ),
        duration: Duration(milliseconds: 500),
      ),
      preferredSize: Size.fromHeight(60),
    );
  }
}
