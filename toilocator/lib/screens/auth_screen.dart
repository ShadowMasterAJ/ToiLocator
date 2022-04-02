import 'package:flutter/material.dart';
import '../widgets/auth_card.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome!',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            AuthForm(
              
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
