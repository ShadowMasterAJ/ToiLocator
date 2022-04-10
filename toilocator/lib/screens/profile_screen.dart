import 'package:flutter/material.dart';
import 'package:toilocator/global_variables/my_globals.dart';

import './home_map_screen.dart';
import '../palette.dart';

/// UI for the profile screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(width: 100, child: HomeMapScreen.buildDrawer(context)),
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
                              style: Theme.of(context).textTheme.headline5),
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
              SizedBox(
                height: 55,
              ),
              Text(
                globalName,
                style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Age', style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 8),
              Text(globalAge.toString(),
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              SizedBox(height: 30),
              Text('Gender', style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 8),
              Text(globalGender,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95)))),
              SizedBox(height: 30),
              Text('Email', style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 8),
              Text(globalEmail,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(color: Color.fromARGB(255, 95, 95, 95))),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: 30),
            ],
          );
        }),
      ),
    );
  }
}
