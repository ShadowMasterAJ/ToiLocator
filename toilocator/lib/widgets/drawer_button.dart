import 'package:flutter/material.dart';
import 'package:toilocator/palette.dart';

class DrawerButton extends StatelessWidget {

    BuildContext ctx;
    String text;
    IconData icn;
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