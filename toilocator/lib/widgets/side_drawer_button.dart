// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:toilocator/palette.dart';

/// Builds a tappable button on the side drawer for navigation.
class DrawerButton extends StatelessWidget {
  BuildContext ctx;

  /// The name of the button function.
  String text;

  /// The icon of the button function.
  IconData icn;

  /// The function to be executed upon tapping on the button.
  VoidCallback onTap;
  DrawerButton(this.ctx, this.text, this.icn, this.onTap);

  @override
  Widget build(BuildContext context) {
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
}
