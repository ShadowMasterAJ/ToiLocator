import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import 'package:toilocator/services/auth.dart';
import '/screens/profile_screen.dart';
import '/screens/auth_screen.dart';
import 'palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toilocator/services/userDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



//the app will always initialise firebase when it starts
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


//may add in the wrapper, for users who wish to comment, switch to register screen, if not, back to homeMap screen
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        // StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //   builder: BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot
        // )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToiLocator',
        theme: ThemeData(
          backgroundColor: Palette.beige[50],
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            headline2: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            headline3: TextStyle(fontSize: 24.0, color: Colors.black),
            headline4: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
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
        //),
      ),
    );
  }
}
