import 'package:flutter/material.dart';
import '../palette.dart';
import '../widgets/side_drawer_button.dart';
import './home_map_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Builder(builder: (context) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Palette.beige[500],
                    image: DecorationImage(
                        image: NetworkImage("add your image URL here "),
                        fit: BoxFit.cover)),
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
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.settings)),
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
                "<UserInput>",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide.none),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: const Size(100, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          onPressed: () {},
                          child: Text("Info"),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: const Size(100, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          onPressed: () {},
                          child: Text(
                              "Reviews"), // TODO: add setState logic to change behavior and apperance onClick
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('Age', style: Theme.of(context).textTheme.headline1),
              Text('<UserInput>', style: Theme.of(context).textTheme.headline3),
              Spacer(),
              Text('Gender', style: Theme.of(context).textTheme.headline1),
              Text('<UserInput>', style: Theme.of(context).textTheme.headline3),
              Spacer(),
              Text('Email', style: Theme.of(context).textTheme.headline1),
              Text('<UserInput>', style: Theme.of(context).textTheme.headline3),
              Spacer(),
            ],
          );
        }),
      ),
    );
  }
}