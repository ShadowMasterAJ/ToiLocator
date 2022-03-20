import 'package:firebase_auth/firebase_auth.dart';

/// Instantiate FirebaseAuthenication instance
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void checkUser() {}
  void createUser() {}
  void updateUser() {}
  void deleteUser() {}
  void connectToFirebase() {}

  /// Method to sign out anonymously.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
