import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/UI/UserLogin/UserIntro.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => UserIntroPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tealBackground,
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
