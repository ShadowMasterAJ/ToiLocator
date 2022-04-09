import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toilocator/global_variables/my_globals.dart';
import 'package:toilocator/screens/auth_screen.dart';
import '../palette.dart';
import '../widgets/side_drawer_button.dart';
import './home_map_screen.dart';
import 'package:toilocator/services/userDatabase.dart' as ud;
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      drawer: Container(width: 100, child: HomeMapScreen.buildDrawer(context)),
      // backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Builder(builder: (context) {
          double profileRadius = 60;
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Palette.beige[500],
                ),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(Icons.menu_rounded)),
                          Text('Profile',
                              style: Theme.of(context).textTheme.headline4),
                          SizedBox(width: 40),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment(0.0, 4.5),
                      child: CircleAvatar(
                        radius: profileRadius,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://yt3.ggpht.com/ytc/AKedOLQ0ZzmuKDUAnn9PnXylG707Oii6hd73U8rXbRGW=s900-c-k-c0x00ffffff-no-rj'),
                          radius: profileRadius - 5,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                globalName,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 50),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
                indent: 15,
                endIndent: 15,
                height: 20,
              ),
              Spacer(),
              Text('Age', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 8),
              Text(globalAge.toString(),
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              Spacer(),
              Text('Gender', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 8),
              Text(globalGender,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              Spacer(),
              Text('Email', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 8),
              Text(globalEmail,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95))),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              Spacer(),
              TextButton(
                  child: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Palette.beige[500], fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await _firebaseAuth.signOut();
                    globalName = "You are not logged in...";
                    globalAge = 0;
                    globalGender = "";
                    globalEmail = "";
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeMapScreen()));
                  }),
              Spacer(),
            ],
          );
        }),
      ),
    );
  }
}
