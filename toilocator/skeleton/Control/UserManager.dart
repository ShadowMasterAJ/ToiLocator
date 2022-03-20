//import 'package:firebase_auth/firebase_auth.dart';

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

/// Getter for Firebase user's user ID [uid].
String getUserID(){
  return _auth.currentUser.uid;
}

/// Getter for Firebase user's profile image URL [photoURL].
/*String getUserImageURL(){
  return _auth.currentUser.photoURL;
}*/

/// Getter for Firebase user's profile image.
/**getProfilePic(){
    if (_auth.currentUser.photoURL != null) {
      return NetworkImage(_auth.currentUser.photoURL.toString());
    } else {
      return Icon(Icons.account_circle, size: 100);
    }
}**/

/// Getter for Firebase user's display name [displayName].
getProfileName(){
  return _auth.currentUser.displayName.toString();
}

/// Getter for Firebase user's email [email].
getEmail(){
  return _auth.currentUser.email.toString();
}

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