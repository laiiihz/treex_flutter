import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/MainHomeUI/HomeStructure.dart';
import 'package:treex_flutter/UI/Overlay/DrawerMenus/NetworkSettings.dart';
import 'package:treex_flutter/UI/UserLogin/UserIntro.dart';
import 'package:treex_flutter/utils/NetUtil.dart';
import 'package:uuid/uuid.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkPermission();
    firstUser() async {
      isFirstStartUp().then((value) {
        if (value) {
          genUUID();
        }
      });
      initIpAndPort().then((_) {
        checkServerConnection().then((value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => UserIntroPage(),
            ),
          );
          if (!value) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => NetworkSettingsPage()));
          } else {
            isLogIn().then((value) {
              if (value) {
                loginOperations();
                //TODO login operations
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => HomeStructurePage()));
              }
            });
          }
        });
      });
    }

    firstUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? tealNightBackground
              : tealBackground,
      body: Center(
        child: FlareActor(
          'assets/treex-brand.flr',
          fit: BoxFit.cover,
          animation: 'brand',
        ),
      ),
    );
  }

  Future initIpAndPort() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final provider = Provider.of<AppProvider>(context);
    provider.setIPAndPort(
        '${sharedPreferences.getString('net_addr') ?? '127.0.0.1'}:${sharedPreferences.getString('net_port') ?? '8080'}');
  }

  Future<bool> checkServerConnection() async {
    final provider = Provider.of<AppProvider>(context);
    return await CheckConnectionUtil(serverPrefix: provider.serverPrefix)
        .check();
  }

  Future<bool> isFirstStartUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool notFirst = sharedPreferences.getBool('not_first_login') ?? false;
    if (!notFirst) {
      return false;
    } else {
      sharedPreferences.setBool('not_first_login', true);
      return true;
    }
  }

  genUUID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uuid = Uuid();
    sharedPreferences.setString('only_uuid', uuid.v4());
  }

  Future<bool> isLogIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getString('token') ?? '').length != 0;
  }

  Future loginOperations() async {
    final provider = Provider.of<AppProvider>(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    provider.setUserName(sharedPreferences.getString('name'));
    provider.setToken(sharedPreferences.getString('token'));
  }

  Future checkPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }
}
