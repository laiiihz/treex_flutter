import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/MainHomeUI/HomeStructure.dart';
import 'package:treex_flutter/UI/UserLogin/UserIntro.dart';
import 'package:uuid/uuid.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    firstUser() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final provider = Provider.of<AppProvider>(context);
      provider.setIPAndPort(
          '${sharedPreferences.getString('net_addr')}:${sharedPreferences.getString('net_port')}');
      bool notFirst = sharedPreferences.getBool('not_first_login') ?? false;
      if (!notFirst) {
        print('gen');
        var uuid = Uuid();
        sharedPreferences.setBool('not_first_login', true);
        sharedPreferences.setString('only_uuid', uuid.v4());
      }
      if ((sharedPreferences.getString('token') ?? '').length != 0) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        provider.setUserName(sharedPreferences.getString('name'));
        provider.setToken(sharedPreferences.getString('token'));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => HomeStructurePage()));
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => UserIntroPage(),
            ),
          );
        });
      }
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
}
