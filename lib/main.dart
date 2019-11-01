import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/UI/Intro/Splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.blueGrey,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treex',
      theme: defaultTheme,
      home: SplashPage(),
    );
  }
}
