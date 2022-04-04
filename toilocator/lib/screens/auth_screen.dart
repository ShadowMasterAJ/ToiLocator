import 'package:flutter/material.dart';
import 'package:toilocator/palette.dart';
import '../widgets/auth_card.dart';
import '../screens/home_map_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.beige[400],
      ),
      drawer: SafeArea(
        child: Container(
          width: 100,
          child: HomeMapScreen.buildDrawer(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome!',
                    // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(height: 10),
                AuthForm(),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
