import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toilocator/palette.dart';
import 'package:toilocator/widgets/map_stack.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toilocator/screens/auth_screen.dart';
import 'package:toilocator/widgets/side_drawer_button.dart';
import 'package:toilocator/screens/profile_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeMapScreen extends StatelessWidget {
  HomeMapScreen({Key? key}) : super(key: key);

  static Widget buildDrawer(BuildContext context) {
    return Scaffold(
      body: Drawer(
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
                  if (FirebaseAuth.instance.currentUser == null) {
                    Fluttertoast.showToast(
                        msg: "Please sign up or sign in to see your profile!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Color.fromARGB(255, 99, 99, 99),
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  }
                }),
                // DrawerButton(context, 'Help', Icons.help, () {}),
                (FirebaseAuth.instance.currentUser == null
                    ? DrawerButton(context, 'Login', Icons.login, () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              settings: RouteSettings(name: "/loginPage"),
                              builder: (context) => AuthScreen()),
                        );
                      })
                    : DrawerButton(context, 'Logout', Icons.logout, () async {
                        // () async {
                        final FirebaseAuth _firebaseAuth =
                            FirebaseAuth.instance;
                        await _firebaseAuth.signOut();
                        // globalName = "You are not logged in...";
                        // globalAge = 0;
                        // globalGender = "";
                        // globalEmail = "";
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeMapScreen()));
                      })),

                // DrawerButton(context, 'Login', Icons.logout, () {
                //   Navigator.pop(context);
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         settings: RouteSettings(name: "/loginPage"),
                //         builder: (context) => AuthScreen()),
                //   );
                // }),
                Spacer(),
                Container(
                  child: Center(child: Text('V4.20.69')),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Palette.beige[200]),
                )
              ],
            ),
          )),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,

        // appBar: AppBar(title: Text('Toilocator')),
        body: SafeArea(
            child: MapStack(
          getLocFromInfo: (double lat, double long) {},
        )),
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
