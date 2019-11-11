import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/ColorSchemes.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
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
  runApp(
    ChangeNotifierProvider.value(
      value: AppProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return MaterialApp(
      title: 'Treex',
      theme: provider.nightModeOn ? ThemeData.dark() : defaultTheme,
      home: SplashPage(),
    );
  }
}
