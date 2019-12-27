import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/About.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/NetworkSettings.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/UserSettings.dart';
import 'package:treex_flutter/UI/UserLogin/UserIntro.dart';
import 'package:treex_flutter/canvas/PaintAccount.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/utils/AuthNetUtils.dart';
import 'package:treex_flutter/utils/NetUtil.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  int _spaceUsed = 0;
  int _spaceFree = 0;
  double _progress;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getSpace(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Stack(
      children: <Widget>[
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? SizedBox()
            : CustomPaint(
                painter: PaintAccountTop(),
                size: Size(MediaQuery.of(context).size.width, 400),
              ),
        RefreshIndicator(
            child: ListView(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              children: [
                AnimationLimiter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: Duration(milliseconds: 800),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        child: FadeInAnimation(child: widget),
                        verticalOffset: 150,
                      ),
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserSettingsPage()),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    minRadius: 30,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            provider.userName,
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          LinearProgressIndicator(
                                            value: _progress,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              Text(
                                                  '${getLengthString(_spaceUsed)}/${getLengthString(_spaceFree)}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                InkWell(
                                  child: ListTile(
                                    leading: Icon(Icons.sentiment_satisfied),
                                    title: Text(S.of(context).about),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AboutPage(),
                                      ),
                                    );
                                  },
                                ),
                                InkWell(
                                  child: ListTile(
                                    leading: Icon(Icons.share),
                                    title: Text(S.of(context).share),
                                  ),
                                  onTap: () {
                                    Share.share(
                                        'https://github.com/laiiihz/treex_flutter');
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              NetworkSettingsPage()),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.language),
                                    title: Text(S.of(context).network_settings),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UserIntroPage()),
                                    );
                                    deleteTokenFromShared() async {
                                      SharedPreferences shared =
                                          await SharedPreferences.getInstance();
                                      DeleteTokenUtil(
                                              token: provider.token,
                                              serverPrefix:
                                                  '${provider.serverPrefix}')
                                          .delete();
                                      shared.setString('token', '');
                                    }

                                    deleteTokenFromShared();
                                  },
                                  child: Text(S.of(context).log_out),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onRefresh: () async {
              setState(() {
                _progress = null;
              });
              getSpace(context);
            })
      ],
    );
  }

  getSpace(BuildContext context) async {
    final provider = Provider.of<AppProvider>(context);
    await GetSpace(baseUrl: provider.serverPrefix, token: provider.token)
        .get()
        .then((list) {
      setState(() {
        _spaceUsed = list[0];
        _spaceFree = list[1];
        _progress = _spaceUsed / _spaceFree;
      });
    });
  }
}
