import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toilocator/global_variables/my_globals.dart';
import 'package:toilocator/screens/auth_screen.dart';
import '../palette.dart';
import '../widgets/side_drawer_button.dart';
import './home_map_screen.dart';
import 'package:toilocator/services/userDatabase.dart' as ud;
import 'package:firebase_auth/firebase_auth.dart';


class ProfileScreen extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
     final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      drawer: Container(width: 100, child: HomeMapScreen.buildDrawer(context)),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Builder(builder: (context) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Palette.beige[500],
                  // image: DecorationImage(
                  //     image: NetworkImage(
                  //         "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.theguardian.com%2Flifeandstyle%2F2019%2Fnov%2F08%2Fexperience-hide-the-pain-harold-face-became-meme-turned-it-into-career&psig=AOvVaw3xRZQ75mtTZuFLknTsTZCQ&ust=1648968747866000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNiZ47Xl9PYCFQAAAAAdAAAAABAD"),
                  //     fit: BoxFit.cover),
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
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(width: 40),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment(0.0, 2.5),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://yt3.ggpht.com/ytc/AKedOLQ0ZzmuKDUAnn9PnXylG707Oii6hd73U8rXbRGW=s900-c-k-c0x00ffffff-no-rj'),
                          radius: 45,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                globalName,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Age', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 8),
              Text(globalAge.toString(),
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              SizedBox(height: 30),
              Text('Gender', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 8),
              Text(globalGender,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              SizedBox(height: 30),
              Text('Email', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 8),
              Text(globalEmail,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95))),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: 8),
              TextButton(
                child: const Text('Sign Out'),
                onPressed: () async{
                  await _firebaseAuth.signOut();
                  globalName="You are not logged in...";
                  globalAge=0;
                  globalGender="";
                  globalEmail="";
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeMapScreen()));

                }
                ),

            ],
          );
        }),
      ),
    );
  }
}
