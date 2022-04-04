import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  User? _userFromFirebase(auth.User? user){
      if (user==null) return null;
      else return User(uid:user.uid);
  }


/// the stream that parent widgets listen to, to be notified of authentication changes.
/// Returns a firebase user, mapped to custom `User` object when change in auth- sign in or out.
Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
     }


// Future signInUser(String email, String pwd, {context}) async {
//     try {
//       await _firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: pwd)
//           .then((result) {
//         auth.User? user = result.user;
//         return _userFromFirebase(user);
//       }).catchError((err) {
//         if (err.code == 'user-not-found') {
//           Flushbar(
//             message: "No user found for that email.",
//             duration: Duration(seconds: 7),
//           )..show(context);
//         } else if (err.code == 'wrong-password') {
//           Flushbar(
//             message: "Wrong password provided for that user.",
//             duration: Duration(seconds: 7),
//           )..show(context);
//         } else {
//           Flushbar(
//             message: "Internal Error: Something went wrong.",
//             duration: Duration(seconds: 7),
//           )..show(context);
//         }
//       });
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
Future<User?> signInWithEmailAndPassword(
  String email,
  String password,
)async{
  final credential = await _firebaseAuth.signInWithEmailAndPassword(
    email: email, password: password,
    );

  return _userFromFirebase(credential.user);
}


// void signIn(String email, String password) async{
//   if(_formkey.currentState!.validate()){
//     await _firebaseAuth
//     .signInWithEmailAndPassword(email: email, password: password)
//     .then((uid)=>{
//       Fluttertoast.showToast(msg: "Login Successfully"),
//       Navigator.of(context).pushReplacement(MaterialPageRoute:(builder:(context)=>HomeMapScreen)),
//     }).catchError((e){
//       Fluttertoast.showToast(msg: e!.message);
//     }
//     );

//   }
// }



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

// Future<void> userState() async{
//   await _firebaseAuth.authStateChanges()
//   .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
     
//     } else {
//       print('User is signed in!');
//     }
//   });
}

//auth state change
// FirebaseAuth.instance
//   .authStateChanges()
//   .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });

