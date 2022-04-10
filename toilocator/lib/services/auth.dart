import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as authen;
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class AuthService {
  final authen.FirebaseAuth _firebaseAuth = authen.FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  get auth => null;

  User? _userFromFirebase(authen.User? user){
      if (user==null) return null;
      else return User(uid:user.uid, userName: '', userEmail: '', password: '', gender: '', age: 0);
  }


/// the stream that parent widgets listen to, to be notified of authentication changes.
/// Returns a firebase user, mapped to custom `User` object when change in auth- sign in or out.
Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
     }


Future<User?> signInWithEmailAndPassword(
  String email,
  String password,
)async{
  final credential = await _firebaseAuth.signInWithEmailAndPassword(
    email: email, password: password,
    );

  return _userFromFirebase(credential.user);
}

Future<User?> createUserWithEmailAndPassword(
  String email,
  String password,
)async{
  final credential = await _firebaseAuth.createUserWithEmailAndPassword(
    email: email, password: password,
    );
    return _userFromFirebase(credential.user);
}

Future<void> signOut() async {
  return await _firebaseAuth.signOut();
}

  getCurrentUser() async {
    return await auth.FirebaseAuth.instance.currentUser;
  }

}


Future<User> getUser() async {
    final firebaseUser = await authen.FirebaseAuth.instance.currentUser;
    return User(uid: firebaseUser!.uid, userName: '', userEmail: '', password: '', gender: '', age: 0);
  }


Future<bool> checkIfEmailInUse(String emailAddress) async {
  try {
    // Fetch sign-in methods for the email address
    final list = await authen.FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

    // In case list is not empty
    if (list.isNotEmpty) {
      // Return true because there is an existing
      //print("the email is in use.");
      return true;
    } else {
      //print("the email is not in use.");
      return false;
    }
  } catch (error) {
    // Handle error
    return true;
  }
}

Future<bool> checkIfPasswordCorrect(String email, String password) async{
            final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
            String result='';
            await usersCollection
            .where('email', isEqualTo: email)
            .get()
            .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) { 
            // if(password==doc['password']){
            //   print("password is correct!");
            //   result='true';             
            // }
            // else {result='false';
            // print("password wrong!!!");}
            result = doc['password'];
            print("the result is"+result);
            });      
            });
            if(result==password) return true;
            else return false;
         
}

Future signIn(String email, String password) async {
    try {
      await authen.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on authen.FirebaseAuthException catch (e) {
      print('Error in auth: $e\n----------------------');
    }

  }

   Future signUp(String email, String name, String Password, String gender, int age) async {
    try {
      await authen.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: Password,
          )
          .then((value) => {postDetailsToFirestore(email, name, Password, gender, age)});
      //await UserDatabaseService(FirebaseAuth.instance.currentUser!.uid).addNewUser(emailController.text, emailController.text, int.parse(emailController.text));
    } on authen.FirebaseAuthException catch (e) {
      print(e);
    }
    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => ProfileScreen()),
    //     (route) => false);
  }

  postDetailsToFirestore(String email, String name, String Password, String gender, int age) async {
    // calling our firestore, calling our user record, sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // writing all the values
    authen.User? user = authen.FirebaseAuth.instance.currentUser;
    String uid=user!.uid;
    User currentUser = User(
      uid: uid, userName: name, userEmail: email, password: Password, gender: gender, age: age);
    currentUser.uid = authen.FirebaseAuth.instance.currentUser!.uid;
    currentUser.userName = name;
    currentUser.userEmail = email;
    currentUser.password = Password;
    currentUser.gender = gender;
    currentUser.age = age;

    // globalAge = currentUser.age;
    // globalName = currentUser.userName;
    // globalEmail = currentUser.userEmail;
    // globalGender = currentUser.gender;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(currentUser.toMap());
  }

