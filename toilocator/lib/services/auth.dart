import 'package:firebase_auth/firebase_auth.dart';
import 'package:toilocator/models/user.dart';
import 'database.dart';
class AuthService {

 final FirebaseAuth _auth = FirebaseAuth.instance;

//the ? makes the return type nullable
 User? _userFromFirebaseUser(FirebaseUser user) {
 //return user!= null? User(uid: user.uid) : null;
 if(user==null) return null;
 else return User(uid: user.uid);
 }


// auth change user stream
//when there is a change of users' status, e.g.switching from login to logout,this stream enables the flutter app to show the change by adapting suitable UI?
//not very sure
Stream<User?> get user {
 return _auth.onAuthStateChanged
 //.map((FirebaseUser user) => _userFromFirebaseUser(user));
 .map(_userFromFirebaseUser);
 }

// sign in with email and password
Future signInWithEmailAndPassword(String email, String password) async{
  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

// register with email and password
Future registerWithEmailAndPassword(String email, String password) async{
  try{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    // create a new document for the user with the uid
    await DatabaseService(uid: user.uid).updateUserData('gender', []);
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

// sign out
Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}