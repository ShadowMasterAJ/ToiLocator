import 'package:flutter/material.dart';
import 'package:toilocator/palette.dart';
import 'package:toilocator/widgets/map_stack.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toilocator/widgets/drawer_button.dart';

class HomeMapScreen extends StatelessWidget {
  HomeMapScreen({Key? key}) : super(key: key);

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
                      DrawerButton(context, 'Map', Icons.map_outlined, () {}),
                      DrawerButton(context, 'Profile', Icons.person_pin, () {}),
                      DrawerButton(context, 'Settings', Icons.settings, () {}),
                      DrawerButton(
                          context, 'Favorite\n Toilets', Icons.favorite, () {}),
                      DrawerButton(context, 'Help', Icons.help, () {}),
                      DrawerButton(context, 'Logout', Icons.logout, () {}),
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
