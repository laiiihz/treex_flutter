import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/UI/AddTools/Tools.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/FilesUI.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/HomeUI.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/MessageUI.dart';
import 'package:treex_flutter/UI/MainHomeUI/SearchPage.dart';
import 'package:treex_flutter/widget/DrawerMain.dart';

class HomeStructurePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeStructureState();
}

class _HomeStructureState extends State<HomeStructurePage> {
  ScreenshotController _screenshotController = ScreenshotController();
  PageController _pageController = PageController(initialPage: 0);
  int _bottomBarCurrentIndex = 0;
  double _titleOpacity = 1.0;
  int _animateTitleIndex = 0;
  Color _appBarColor = tealBackgroundDark;
  Widget _buildTitle(index) {
    String textParam = '';
    switch (index) {
      case 0:
        textParam = 'Home';
        break;
      case 1:
        textParam = 'Message';
        break;
      case 2:
        textParam = 'Files';
        break;
      default:
        textParam = 'Home';
        break;
    }
    return AnimatedOpacity(
      opacity: _titleOpacity,
      duration: Duration(milliseconds: 250),
      child: Text(textParam),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        appBar: PreferredSize(
          child: AnimatedContainer(
            decoration: BoxDecoration(
              color: _appBarColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 20,
                  color: _appBarColor,
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: _buildTitle(_animateTitleIndex),
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
        ),
        drawer: DrawerMainWidget(),
        floatingActionButton: FloatingActionButton(
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
        ),
        floatingActionButtonLocation: _bottomBarCurrentIndex == 0
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            switch (index) {
              case 0:
                setState(() {
                  _appBarColor = tealBackgroundDark;
                });
                break;
              case 1:
                setState(() {
                  _appBarColor = blueBackgroundDark;
                });
                break;
              case 2:
                setState(() {
                  _appBarColor = yellowBackgroundDark;
                });
                break;
            }
            setState(() {
              _bottomBarCurrentIndex = index;
              _titleOpacity = 0.0;
            });
            Future.delayed(Duration(milliseconds: 300), () {
              setState(() {
                _titleOpacity = 1.0;
                _animateTitleIndex = index;
              });
            });
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
            );
          },
          currentIndex: _bottomBarCurrentIndex,
          selectedItemColor: Colors.black54,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.cloud,
                color: Colors.yellow,
              ),
              title: Text('Home'),
              backgroundColor: tealBackground,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                color: Colors.teal,
              ),
              title: Text('Message'),
              backgroundColor: blueBackground,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.folder,
                color: Colors.blue,
              ),
              title: Text('Folder'),
              backgroundColor: yellowBackground,
            ),
          ],
        ),
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return HomeUIPage();
                break;
              case 1:
                return MessageUIPage();
                break;
              case 2:
                return FilesUIPage();
                break;
              default:
                return HomeUIPage();
                break;
            }
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
