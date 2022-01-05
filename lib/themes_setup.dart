import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
  //Regular-Theme
    ThemeData(
        primaryColor: Color(0xFF2196F3),
        primaryColorLight: const Color(0xFF00838F),
        primaryColorDark: Color(0xFF263238),
        accentColor: Color(0xFF1B5E20),
        textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.black, fontSize: 40, fontFamily: 'PipeDream'),
            headline2: TextStyle(
                color: Colors.white, fontSize: 40, fontFamily: 'PipeDream'),
            headline3: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: 'PipeDream'),
            headline4: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'PipeDream'),
            bodyText1: TextStyle(
                color: Colors.black, fontSize: 17, fontFamily: 'PipeDream'),
            bodyText2: TextStyle(
                color: Colors.white, fontSize: 17, fontFamily: 'PipeDream'),
            button: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'PipeDream')),
        iconTheme: IconThemeData(color: Color(0xFFFF9800))),
   
    ThemeData(
        primaryColor: Color(0xFF212121),
        primaryColorLight: const Color(0xFF43A047),
        primaryColorDark: Color(0xFF1B5E20),
        accentColor: Color(0xFF212121),
        textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.black, fontSize: 42, fontFamily: 'PipeDream'),
            headline2: TextStyle(
                color: Colors.white, fontSize: 42, fontFamily: 'PipeDream'),
            headline3: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: 'PipeDream'),
            headline4: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'PipeDream'),
            bodyText1: TextStyle(
                color: Colors.black, fontSize: 17, fontFamily: 'PipeDream'),
            bodyText2: TextStyle(
                color: Colors.white, fontSize: 17, fontFamily: 'PipeDream'),
            button: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'PipeDream')),
        iconTheme: IconThemeData(color: Color(0xFF212121))
        ),
   ];
}
