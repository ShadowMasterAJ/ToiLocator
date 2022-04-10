import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global_variables/my_globals.dart';
import '../models/user.dart';
import '../palette.dart';
import '../screens/profile_screen.dart';
import '../services/auth.dart';
import '../services/userDatabase.dart';
import 'AuthCard_Widgets/age_field.dart';
import 'AuthCard_Widgets/confPassword_field.dart';
import 'AuthCard_Widgets/email_field.dart';
import 'AuthCard_Widgets/password_field.dart';
import 'AuthCard_Widgets/username_field.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

bool _isObscure = true;
enum AuthMode { Signup, Login }

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;

  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  User currentUser = User(
      uid: '', userName: '', userEmail: '', password: '', gender: '', age: 0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authMode = AuthMode.Signup;
    // });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final navigatorKey = GlobalKey<NavigatorState>();
  final authService = AuthService();
  final _auth = auth.FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String dropDownValue = "Female";
  //final _auth = auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //navigatorKey: navigatorKey;
    final authService = Provider.of<AuthService>(context);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _authMode == AuthMode.Signup
                ? Username_Field(
                    nameController: nameController,
                  )
                : SizedBox(
                    height: 5,
                  ),
            Email_Field(emailController: emailController),
            SizedBox(
              height: 0,
            ),
            Password_Field(passwordController: passwordController),
            _authMode == AuthMode.Signup
                ? ConfPassword_Field(
                    confirmController: confirmController,
                  )
                : SizedBox(),
            _authMode == AuthMode.Signup
                ? Column(children: [
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Age_Field(ageController: ageController),
                      SizedBox(width: 30),
                      DropdownButton<String>(
                        value: dropDownValue,
                        elevation: 16,
                        style: Theme.of(context).textTheme.bodyText2,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue =
                                newValue!; // CAN TAKE GENDER INPUT AS DROPDOWNVALUE (GLOBAL)
                          });
                        },
                        underline: Container(
                          height: 2,
                          color: Palette.beige[100],
                        ),
                        icon: const Icon(Icons.arrow_downward),
                        items: <String>['Female', 'Male']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ]),
                    SizedBox(height: 10),
                  ])
                : SizedBox(
                    height: 16,
                  ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Palette.beige,
                ),
                onPressed: () async {
                  await authCorrecter(context);
                },
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.bodyText1?.merge(
                      TextStyle(color: Color.fromARGB(255, 155, 155, 155))),
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Palette.beige[100] as Color),
                ),
              ),
            ]),
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
                        (states) => Palette.beige[100] as Color),
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

  Future<void> authCorrecter(BuildContext context) async {
    bool exist = await checkIfEmailInUse(emailController.text);
    if (_authMode == AuthMode.Signup) {
      if (emailController.text.isEmpty ||
          !emailController.text.contains('@')) {
        const snackBar = SnackBar(
          content: Text('Please enter a valid email.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (exist) {
        const snackBar = SnackBar(
          content: Text('Account exists. Please log in!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (passwordController.text.length < 6) {
        const snackBar = SnackBar(
          content: Text(
              'Password must be at least 7 characters long.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (confirmController.text !=
          passwordController.text) {
        const snackBar = SnackBar(
          content: Text('Passwords do not match.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (ageController.text.isEmpty) {
        const snackBar = SnackBar(
          content: Text('Please register with your age.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else{
        signUp(emailController.text, nameController.text, passwordController.text, dropDownValue, int.parse(ageController.text));
            currentUser.uid = auth.FirebaseAuth.instance.currentUser!.uid;
            globalAge = int.parse(ageController.text);
            globalName = nameController.text;
            globalEmail = emailController.text;
            globalGender = dropDownValue;
                Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => ProfileScreen()),
        (route) => false);
        }
    } else {
      bool verified = await checkIfPasswordCorrect(
          emailController.text, passwordController.text);
      print(verified);
      if (!exist) {
        const snackBar = SnackBar(
          content: Text('No account found. Please sign up.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (!verified) {
        const snackBar = SnackBar(
          content: Text('Wrong password. Please enter again.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else{
        signIn(emailController.text, passwordController.text);
            globalEmail = emailController.text;
    globalAge = await getUserAge(globalEmail);
    globalName = await getUserNameByEmail(globalEmail);
    globalGender = await getUserGender(globalEmail);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProfileScreen()));}
    }
  }

  // Future signIn() async {
  //   try {
  //     await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //   } on auth.FirebaseAuthException catch (e) {
  //     print('Error in auth: $e\n----------------------');
  //   }
  //   globalEmail = emailController.text;
  //   globalAge = await getUserAge(globalEmail);
  //   globalName = await getUserNameByEmail(globalEmail);
  //   globalGender = await getUserGender(globalEmail);

  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => ProfileScreen()));
  // }

  // Future signUp() async {
  //   try {
  //     await auth.FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //           email: emailController.text.trim(),
  //           password: passwordController.text.trim(),
  //         )
  //         .then((value) => {postDetailsToFirestore()});
  //     //await UserDatabaseService(FirebaseAuth.instance.currentUser!.uid).addNewUser(emailController.text, emailController.text, int.parse(emailController.text));
  //   } on auth.FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  //   Navigator.pushAndRemoveUntil(
  //       (context),
  //       MaterialPageRoute(builder: (context) => ProfileScreen()),
  //       (route) => false);
  // }

  // postDetailsToFirestore() async {
  //   // calling our firestore, calling our user record, sending these values
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   // writing all the values
  //   currentUser.uid = auth.FirebaseAuth.instance.currentUser!.uid;
  //   currentUser.userName = nameController.text;
  //   currentUser.userEmail = emailController.text;
  //   currentUser.password = passwordController.text;
  //   currentUser.gender = dropDownValue;
  //   currentUser.age = int.parse(ageController.text);

  //   globalAge = currentUser.age;
  //   globalName = currentUser.userName;
  //   globalEmail = currentUser.userEmail;
  //   globalGender = currentUser.gender;

  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(user?.uid)
  //       .set(currentUser.toMap());
  // }
}
