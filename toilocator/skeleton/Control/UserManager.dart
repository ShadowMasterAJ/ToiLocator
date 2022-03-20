import 'package:firebase_auth/firebase_auth.dart';
///This class allows the users to create accounts, check or update their account information and connect the information to the firebase
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
  ///check user information
  void checkUser() {}
  ///create a new user account
  void createUser() {}
  ///update user's information
  void updateUser() {}
  ///delete the user account
  void deleteUser() {}
  ///connect to the user account in database
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
