import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '/screens/auth_screen.dart';
import 'palette.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToiLocator',
      theme: ThemeData(
        primarySwatch: Palette.beige,
        backgroundColor: Palette.beige[100],
        accentColor: Colors.red,
        // accentColorBrightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Palette.beige,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33.0),
              )),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Palette.beige)),
      ),
      home: HomeScreen(), // TODO Need to add logic for AuthScreen
    );
  }
}
