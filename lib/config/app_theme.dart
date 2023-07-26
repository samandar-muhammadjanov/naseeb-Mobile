// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:naseeb/utils/colors.dart';

class AppTheme {
  static ThemeData light = ThemeData.light().copyWith(
      bottomAppBarColor: white,
      iconTheme: const IconThemeData(color: black),
      listTileTheme: const ListTileThemeData(
        iconColor: black,
      ),
      // fontFamily: 'sfPro',
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0),
      scaffoldBackgroundColor: Colors.white);
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff2b2d3a),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    // fontFamily: 'sfPro',
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kprimaryColor,
      elevation: 0,
    ),

    popupMenuTheme: const PopupMenuThemeData(color: Color(0xff2b2d3a)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff2b2d3a), elevation: 0),
    bottomAppBarColor: const Color(0xff2b2d3a),
    scaffoldBackgroundColor: const Color(0xff2b2d3a),
    iconTheme: const IconThemeData(color: white),
    listTileTheme: const ListTileThemeData(
      iconColor: white,
    ),
  );
}
