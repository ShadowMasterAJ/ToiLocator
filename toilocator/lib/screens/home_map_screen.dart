import 'package:flutter/material.dart';
import 'package:toilocator/palette.dart';
import 'package:toilocator/widgets/map_stack.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toilocator/screens/auth_screen.dart';
import 'package:toilocator/widgets/side_drawer_button.dart';
import 'package:toilocator/screens/profile_screen.dart';

class HomeMapScreen extends StatelessWidget {
  HomeMapScreen({Key? key}) : super(key: key);

  static Widget buildDrawer(BuildContext context) {
    return Drawer(
        backgroundColor: Palette.beige[100],
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              DrawerButton(context, 'Map', Icons.map_outlined, () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeMapScreen()),
                );
              }),
              DrawerButton(context, 'Profile', Icons.person_pin, () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }),
              DrawerButton(context, 'Help', Icons.help, () {}),
              DrawerButton(context, 'Login', Icons.logout, () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
              }),
              Spacer(),
              Container(
                child: Center(child: Text('V4.20.69')),
                width: double.infinity,
                decoration: BoxDecoration(color: Palette.beige[200]),
              )
            ],
          ),
        ));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,

        // appBar: AppBar(title: Text('Toilocator')),
        body: SafeArea(child: MapStack()),
        drawer: SafeArea(
          child: Container(
            width: 100,
            child: buildDrawer(context),
          ),
        ),
      ),
    );
  }
}
