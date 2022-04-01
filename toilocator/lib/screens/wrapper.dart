import 'package:toilocator/models/user.dart';
import 'package:toilocator/screens/auth_screen.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toilocator/services/auth.dart';

//starting screen switching, not necessary for our app
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot){
        if (snapshot.connectionState == ConnectionState.active){
          final User? user=snapshot.data;
          return user==null? AuthScreen(): HomeMapScreen();
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
}