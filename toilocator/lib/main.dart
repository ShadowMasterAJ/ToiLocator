import 'package:flutter/material.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/auth_screen.dart';
import 'palette.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToiLocator',
      theme: ThemeData(
        backgroundColor: Palette.beige[50],

        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 24.0, color: Colors.black),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 18.0),
        ),

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
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.beige)
            .copyWith(secondary: Colors.red),
      ),
      home: HomeMapScreen(), // TODO: Need to add logic for AuthScreen
    );
  }
}
