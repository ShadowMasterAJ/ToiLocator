import 'package:flutter/material.dart';
import 'package:toilocator/palette.dart';
import 'package:toilocator/widgets/map_stack.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeMapScreen extends StatelessWidget {
  HomeMapScreen({Key? key}) : super(key: key);

  Widget drawerButton(
    BuildContext ctx,
    String text,
    IconData icn,
    VoidCallback onTap,
  ) {
    return InkWell(
      radius: 200,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: onTap,
      splashColor: Palette.beige[400],
      child: Container(
        width: MediaQuery.of(ctx).size.width,
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Icon(
            icn,
            color: Palette.beige[900],
          ),
          SizedBox(
            height: 5,
          ),
          Text(text),
          SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(title: Text('Toilocator')),
        body: SafeArea(child: MapStack()),
        // bottomNavigationBar: DraggableScrollableSheet(
        //   builder: (context, scrollController) {
        //     return SingleChildScrollView(
        //       controller: scrollController,
        //       child: Column(),
        //     );
        //   },
        //   initialChildSize: 0.5,
        //   minChildSize: 0.2,
        //   maxChildSize: 0.6,
        //   expand: false,
        // ),

        drawer: SafeArea(
          child: Container(
            width: 100,
            child: Drawer(
                backgroundColor: Palette.beige[100],
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      drawerButton(context, 'Map', Icons.map_outlined, () {}),
                      drawerButton(context, 'Profile', Icons.person_pin, () {}),
                      drawerButton(context, 'Settings', Icons.settings, () {}),
                      drawerButton(
                          context, 'Favorite\n Toilets', Icons.favorite, () {}),
                      drawerButton(context, 'Help', Icons.help, () {}),
                      drawerButton(context, 'Logout', Icons.logout, () {}),
                      Spacer(),
                      Container(
                        child: Center(child: Text('V4.20.69')),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Palette.beige[200]),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
