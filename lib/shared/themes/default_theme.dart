import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[200],
  primaryColor: Colors.blue,
  primarySwatch: Colors.blue,
  accentColor: Colors.blue,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
    toolbarTextStyle: TextStyle(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
);
