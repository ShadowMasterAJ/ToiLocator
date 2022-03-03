import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

bool _isObscure = true;
enum AuthMode { Signup, Login }

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authMode = AuthMode.Signup;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _authMode == AuthMode.Signup
                ? Card(
                    color: Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Username',
                        hintStyle:
                            TextStyle(color: Color(0xFFACACAC), fontSize: 18),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white54, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.red)),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 5,
                  ),
            Card(
              color: Color(0xFFF3F3F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 18),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white54, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.red)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Card(
              color: Color(0xFFF3F3F3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 18),
                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).primaryColorDark),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white54, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.red)),
                ),
              ),
            ),
            _authMode == AuthMode.Signup
                ? Card(
                    color: Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Confirm Password',
                        hintStyle:
                            TextStyle(color: Color(0xFFACACAC), fontSize: 18),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white54, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.red)),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ),
            Padding(padding: EdgeInsets.all(16)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    _authMode == AuthMode.Signup ? 'Sign Up' : 'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).primaryColor),
              ),
            ),
            Divider(
              thickness: 2,
              indent: 15,
              endIndent: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                Text(
                  _authMode == AuthMode.Signup
                      ? 'Already a User?'
                      : 'First time here?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _authMode == AuthMode.Signup
                          ? _authMode = AuthMode.Login
                          : _authMode = AuthMode.Signup;
                    });
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context).primaryColor),
                  ),
                  child: Text(
                    _authMode == AuthMode.Signup ? 'Login' : 'Sign Up',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
