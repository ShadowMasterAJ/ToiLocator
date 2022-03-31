import 'package:toilocator/models/user.dart';
import 'package:toilocator/screens/auth_screen.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//starting screen switching, not necessary for our app
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    
    // return either the Home or Authenticate widget
    return AuthScreen();
    
  }
}