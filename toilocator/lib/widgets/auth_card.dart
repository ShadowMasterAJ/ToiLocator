import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toilocator/models/user.dart';
import 'package:toilocator/palette.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import 'package:toilocator/screens/profile_screen.dart';
import 'package:toilocator/screens/wrapper.dart';
import 'package:toilocator/services/userDatabase.dart';
import '../services/auth.dart';
import 'package:toilocator/services/auth.dart';
import 'package:toilocator/global_variables/my_globals.dart';


class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

bool _isObscure = true;
enum AuthMode { Signup, Login }

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;

  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  User currentUser = User(uid: '', userName: '', userEmail: '', password: '', gender: '', age: 0);
  //UserRecord userRecord = UserRecord(uid: '', userName: '', userEmail: '', password: '', gender: '', age: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user?.uid)
    //     .get()
    //     .then((value) {
    //   this.userRecord = UserRecord.fromMap(value.data());
    //   setState(() {});
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
                ? Card(
                    color: Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      maxLength: 15,
                      controller: nameController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Username',
                        hintStyle:
                            TextStyle(color: Color(0xFFACACAC), fontSize: 18),
                        suffixIcon: Icon(
                          Icons.person,
                          color: Palette.beige[500],
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
              child: TextFormField(
                controller: emailController,
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
              child: TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 18),
                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Palette.beige[500]),
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
                      controller: confirmController,
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
            _authMode == AuthMode.Signup
                ? Column(children: [
                    SizedBox(height: 10),
                    Row(children: [
                      SizedBox(
                        // FIGURE OUT HOW TO RETRIEVE AGE INPUT
                        width: 100,
                        child: Flexible(
                          child: TextField(
                            // textAlignVertical: TextAlignVertical.top,
                            controller: ageController,
                            maxLines: null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: 'Age',
                              alignLabelWithHint: true,
                              // contentPadding:
                              //     EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      DropdownButton<String>(
                        value: dropDownValue,
                        elevation: 16,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 94, 55, 17)),
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
                        items: <String>['Female', 'Male'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ]),
                    SizedBox(height: 10),
                  ])
                : Padding(padding: EdgeInsets.all(16)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Palette.beige,
                ),
                onPressed: () async {
                  bool exist = await checkIfEmailInUse(emailController.text);
                  if (_authMode == AuthMode.Signup) {
                    if(emailController.text.isEmpty || !emailController.text.contains('@')){               
                      const snackBar = SnackBar(
                      content: Text('Please enter a valid email.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else if(exist){
                      const snackBar = SnackBar(
                      content: Text('Account exists. Please log in.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }
                    else if(passwordController.text.length<6){
                      const snackBar = SnackBar(
                      content: Text('Password must be at least 7 characters long.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else if(confirmController.text != passwordController.text){
                      const snackBar = SnackBar(
                      content: Text('Password does not match.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);                 
                    }
                    else if(ageController.text.isEmpty){
                      const snackBar = SnackBar(
                      content: Text('Please register with your age.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else signUp();
                  } else {
                    bool verified = await checkIfPasswordCorrect(emailController.text, passwordController.text);
                    print(verified);
                    if(!exist){
                      const snackBar = SnackBar(
                      content: Text('No account found. Please sign up.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else if(!verified){
                      const snackBar = SnackBar(
                      content: Text('Wrong password. Please enter again.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                                  
                    else signIn();
                    

                  }
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

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on auth.FirebaseAuthException catch (e) {
      print(e);
    }
    globalEmail=emailController.text;
    globalAge=await getUserAge(globalEmail);
    globalName=await getUserNameByEmail(globalEmail);
    globalGender=await getUserGender(globalEmail);
    
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  Future signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((value) => {postDetailsToFirestore()});
      //await UserDatabaseService(FirebaseAuth.instance.currentUser!.uid).addNewUser(emailController.text, emailController.text, int.parse(emailController.text));
    } on auth.FirebaseAuthException catch (e) {
      print(e);
    }
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => ProfileScreen()),
        (route) => false);
  }

  postDetailsToFirestore() async {
    // calling our firestore, calling our user record, sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // writing all the values
    currentUser.uid = auth.FirebaseAuth.instance.currentUser!.uid;
    currentUser.userName = nameController.text;
    currentUser.userEmail = emailController.text;
    currentUser.password = passwordController.text;
    currentUser.gender = dropDownValue;
    currentUser.age = int.parse(ageController.text);

    globalAge=currentUser.age;
    globalName=currentUser.userName;
    globalEmail=currentUser.userEmail;
    globalGender=currentUser.gender;

    // await firebaseFirestore
    //     .collection("users")
    //     .doc(user?.uid)
    //     .set(userRecord.toMap());

        await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(currentUser.toMap());
  }
}
