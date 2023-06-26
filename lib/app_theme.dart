import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor:
        const Color(0xFF00008B), // Adjust the primary color to your preference
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.grey[50],
    cardColor: Colors.white,
    dividerColor: Colors.grey[300],
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      headline2: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      headline3: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      headline4: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      headline5: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      subtitle1: TextStyle(fontSize: 16, color: Colors.black),
      subtitle2: TextStyle(fontSize: 14, color: Colors.black),
      bodyText1: TextStyle(fontSize: 14, color: Colors.black),
      bodyText2: TextStyle(fontSize: 12, color: Colors.black),
      caption: TextStyle(fontSize: 12, color: Colors.black),
      button: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      overline: TextStyle(
          fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    appBarTheme: darkAppBarTheme,
    // Add other theme properties specific to the light theme
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo, // Adjust the primary color to your preference
    scaffoldBackgroundColor: Colors.grey[900],
    canvasColor: Colors.grey[800],
    cardColor: Colors.grey[850],
    dividerColor: Colors.grey[700],
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      headline3: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      headline4: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      headline5: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      subtitle1: TextStyle(fontSize: 16, color: Colors.white),
      subtitle2: TextStyle(fontSize: 14, color: Colors.white),
      bodyText1: TextStyle(fontSize: 14, color: Colors.white),
      bodyText2: TextStyle(fontSize: 12, color: Colors.white),
      caption: TextStyle(fontSize: 12, color: Colors.white),
      button: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      overline: TextStyle(
          fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    appBarTheme: darkAppBarTheme,
    // Add other theme properties specific to the dark theme
  );
}

AppBarTheme darkAppBarTheme = AppBarTheme(
  backgroundColor: Colors.grey[900],
  elevation: 0,
  shadowColor: Colors.transparent,
  iconTheme: const IconThemeData(color: Colors.white),
  actionsIconTheme: const IconThemeData(color: Colors.white),
  centerTitle: false,
  titleSpacing: 0,
  toolbarHeight: kToolbarHeight,
  toolbarTextStyle: const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  titleTextStyle: const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  systemOverlayStyle: SystemUiOverlayStyle.light,
);
