import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
  //Regular-Theme
    ThemeData(
        primaryColor: Color(0xFF2196F3),
        primaryColorLight: const Color(0xFF00838F),
        primaryColorDark: Color(0xFF263238),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                color: Colors.black, fontSize: 40, fontFamily: 'ArcadeClassic'),
            displayMedium: TextStyle(
                color: Colors.white, fontSize: 40, fontFamily: 'ArcadeClassic'),
            displaySmall: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: 'ArcadeClassic'),
            headlineMedium: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'ArcadeClassic'),
            bodyLarge: TextStyle(
                color: Colors.black, fontSize: 17, fontFamily: 'ArcadeClassic'),
            bodyMedium: TextStyle(
                color: Colors.white, fontSize: 17, fontFamily: 'ArcadeClassic'),
            labelLarge: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'ArcadeClassic')),
        iconTheme: IconThemeData(color: Color(0xFFFF9800)), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF1B5E20))),
   
    ThemeData(
        primaryColor: Color(0xFF212121),
        primaryColorLight: const Color(0xFF43A047),
        primaryColorDark: Color(0xFF1B5E20),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                color: Colors.black, fontSize: 42, fontFamily: 'ArcadeClassic'),
            displayMedium: TextStyle(
                color: Colors.white, fontSize: 42, fontFamily: 'ArcadeClassic'),
            displaySmall: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: 'ArcadeClassic'),
            headlineMedium: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'ArcadeClassic'),
            bodyLarge: TextStyle(
                color: Colors.black, fontSize: 17, fontFamily: 'ArcadeClassic'),
            bodyMedium: TextStyle(
                color: Colors.white, fontSize: 17, fontFamily: 'ArcadeClassic'),
            labelLarge: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'ArcadeClassic')),
        iconTheme: IconThemeData(color: Color(0xFF212121)), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF212121))
        ),
   ];
}
