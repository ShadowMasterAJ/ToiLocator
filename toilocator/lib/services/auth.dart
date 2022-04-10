import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as authen;

import '../models/user.dart';

/// Handles all the authentication communications with Firebase.
/// Contains functions used in the authentication files present in `lib/screens/auth_screen`.
class AuthService {
  final authen.FirebaseAuth _firebaseAuth = authen.FirebaseAuth.instance;
  get auth => null;

  /// Creates custom `User` obj (based on our user in `lib/models`) based on firebase user.
  User? _userFromFirebase(authen.User? user) {
    if (user == null)
      return null;
    else
      return User(
          uid: user.uid,
          userName: '',
          userEmail: '',
          password: '',
          gender: '',
          age: 0);
  }

  /// The stream that parent widgets listen to, to be notified of authentication changes.
  /// Returns a firebase user, mapped to custom `User` object when there is a change in auth- sign in or out.
  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  /// Sign in with specified `email` and `password` using Firebase Auth.
  /// Firebase checks if such a user exists, and returns the `User` ubject if it does and `null` otherwise.
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _userFromFirebase(credential.user);
  }

  /// Creates a user account with email and password.
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  /// Signs out of the current session.
  /// This sign out event is also reflected in the auth stream.
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  /// Gets current user from the firebase according to the authentication state.
  getCurrentUser() async {
    return await auth.FirebaseAuth.instance.currentUser;
  }
}

/// Returns 'User' object.
Future<User> getUser() async {
  final firebaseUser = await authen.FirebaseAuth.instance.currentUser;
  return User(
      uid: firebaseUser!.uid,
      userName: '',
      userEmail: '',
      password: '',
      gender: '',
      age: 0);
}

/// Validates the account, to check whether the email is already registered or not.
Future<bool> checkIfEmailInUse(String emailAddress) async {
  try {
    // Fetch sign-in methods for the email address
    final list = await authen.FirebaseAuth.instance
        .fetchSignInMethodsForEmail(emailAddress);

    // In case list is not empty
    if (list.isNotEmpty) {
      // Return true because there is an existing
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return true;
  }
}

/// Validates the account, to check if the password is correct when user is logging in.
Future<bool> checkIfPasswordCorrect(String email, String password) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  String result = '';
  await usersCollection
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      result = doc['password'];
      print("the result is" + result);
    });
  });
  if (result == password)
    return true;
  else
    return false;
}

/// Sign in with specified `email` and `password` using Firebase Auth.
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
