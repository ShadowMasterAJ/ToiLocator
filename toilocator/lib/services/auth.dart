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

}
