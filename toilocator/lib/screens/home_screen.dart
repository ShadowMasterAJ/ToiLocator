import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
      ),
    );
  }
}
