import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toilocator/models/user.dart';
import 'package:toilocator/screens/auth_screen.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toilocator/services/auth.dart';
import '../palette.dart';
import 'package:toilocator/services/userDatabase.dart' as ud;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:toilocator/global_variables/my_globals.dart';

import '../services/userDatabase.dart';

//starting screen switching, not necessary for our app
class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot){
        if (snapshot.connectionState == ConnectionState.active){
          return displayUserInformation(context, snapshot);
        }
        else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
          ),
          );
        }
      }
      );
    // return either the Home or Authenticate widget
  }

 Widget displayUserInformation(context, snapshot) {
   print("the result is" );
   print(snapshot.data.age);
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
                  height: 200,
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
                        radius: 65,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://yt3.ggpht.com/ytc/AKedOLQ0ZzmuKDUAnn9PnXylG707Oii6hd73U8rXbRGW=s900-c-k-c0x00ffffff-no-rj'),
                          radius: 60,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                globalName,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 15,
              ),
              Text('Age', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 10),
              Text((globalAge).toString(),
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              SizedBox(height: 30),
              Text('Gender', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 10),
              Text(globalGender,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              SizedBox(height: 30),
              Text('Email', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 10),
              Text( globalEmail,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95))),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          );
        }),
      ),
    );
 }
    
}