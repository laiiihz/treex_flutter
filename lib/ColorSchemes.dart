import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/AppProvider.dart';

const blueBackgroundDark = Color(0xff1976d2);
const yellowBackgroundDark = Color(0xfffbc02d);
const tealBackgroundDark = Color(0xff00796b);

const blueBackground = Color(0xffbbdefb);
const yellowBackground = Color(0xfffff9c4);
const tealBackground = Color(0xffb2dfdb);
const tealNightBackground = Color(0x33b2dfdb);
const tealPrimary = Color(0xff26a69a);
const tealDark = Color(0xff00766c);

const limePrimary = Color(0xffc6ff00);
const limeDark = Color(0xff90cc00);

Color getTealBackgroundDark(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark
      ? tealBackgroundDark
      : tealBackground;
}

var defaultTheme = ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: limePrimary,
    splashColor: limeDark,
    foregroundColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    color: tealPrimary,
  ),
  buttonTheme: ButtonThemeData(
    shape: StadiumBorder(),
    buttonColor: tealPrimary,
    textTheme: ButtonTextTheme.primary,
    splashColor: tealDark,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white60,
  ),
  bottomAppBarColor: tealBackground,
);
var darkTheme = ThemeData.dark().copyWith(
  buttonTheme: ButtonThemeData(
    shape: StadiumBorder(),
    buttonColor: tealPrimary,
    textTheme: ButtonTextTheme.primary,
    splashColor: tealDark,
  ),
);
