import 'package:firebase_auth/firebase_auth.dart';
import 'package:toilocator/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebaseUser(FirebaseUser user) {
    return user!= null ? User(uid: user.uid) : null;
  }
  // sign in with email and password



  // register with email and password

  // sign out

}