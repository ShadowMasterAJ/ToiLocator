import 'package:toilocator/models/user.dart';
import 'package:toilocator/screens/auth_screen.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toilocator/services/auth.dart';
import 'package:toilocator/services/userDatabase.dart' as ud;

//starting screen switching, not necessary for our app
class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot){
        if (snapshot.connectionState == ConnectionState.active){
          final User? user=snapshot.data;
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
    final user = snapshot.data;
    print(user);


    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.userName}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email: ${user.userEmail}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Gender: ${user.gender}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Age: ${user.age}", style: TextStyle(fontSize: 20),),
        ),

      ],
    );
  }
}