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