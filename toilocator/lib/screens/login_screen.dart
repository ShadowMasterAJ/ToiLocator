import 'package:flutter/material.dart';
import 'package:toilocator/palette.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();

  const LoginPage({
    Key? key,
  }) : super(key: key);
}

class _LoginPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu_rounded))),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('lib/assets/login_image.png'),
                ))),
            SizedBox(height: 30),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'example@scatapp.com'),
                )),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                )),
            SizedBox(height: 60),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Palette.beige[400],
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: null, // where the logging in happens
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            TextButton(
                child: Text('New User? Create Account'), onPressed: null),
          ],
        )));
  }
}
