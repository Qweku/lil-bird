import 'package:lil_bird/home.dart';
import 'package:lil_bird/themes_setup.dart';
import 'package:flutter/material.dart';
import 'package:lil_bird/welcomePage.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future<void> main() async {
  await ThemeManager.initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: getThemes(),
      defaultThemeMode: ThemeMode.system,
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        title: 'First Game',
        home: LauncherPage(),
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
