import 'package:cloud_firestore/cloud_firestore.dart';

/// Handles all the cloud FireStore database-related functions (read and write).
/// Provides a stream which we listen to in `Home.dart` (after login).
class UserDatabaseService {
  final String uid;
  UserDatabaseService(this.uid);

  /// Collection reference.
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  /// Checks with the firestore whether the user exits or not by user id.
  Future<bool> checkIfUserExists(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot.exists;
  }

  /// Calls the user's CollectionReference to add a new user.
  Future<void> addNewUser(
      String userName, String userEmail, String gender, int age) {
    return usersCollection
        .add({
          'name': userName,
          'email': userEmail,
          'gender': gender,
          'age': age
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  /// Updates user information.
  Future<void> updateUser(
      String uid, String userName, String userEmail, String gender, int age) {
    return usersCollection
        .doc(uid)
        .update({
          'name': userName,
          'email': userEmail,
          'gender': gender,
          'age': age
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  /// Calls the user collection to get user name by uid.
  String getUserName(String uid) {
    String name = "";
    usersCollection
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        return doc['name'];
      });
    });
    return name;
  }

  /// Interacts with the Firestore to read user's data by the uid.
  Future<void> readUserData(String uid) {
    return usersCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  /// Calls Firestore to read user's name by uid.
  Future<void> readUserName(String uid) {
    return usersCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}

/// Calls the user collection to get user's name by uid.
Future<String> getUserName(String uid) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  String name = "";
  await usersCollection
      .where('uid', isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      name = doc['userName'];
    });
  });
  return name;
}

/// Calls the user collection to get user's name by email.
Future<String> getUserNameByEmail(String email) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  String name = "";
  await usersCollection
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      name = doc['userName'];
    });
  });
  return name;
}

/// Call the user collection to get user email by uid
Future<String> getUserEmail(String uid) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  String email = "";
  usersCollection
      .where('uid', isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      email = doc['email'];
    });
  });
  return email;
}

/// Calls the user collection to get user age by user email.
Future<int> getUserAge(String email) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  int age = 0;
  await usersCollection
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      age = doc['age'];
    });
  });
  return age;
}

/// Calls the user collection to get user gender by email.
Future<String> getUserGender(String email) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  String gender = "";
  await usersCollection
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      gender = doc['gender'];
    });
  });
  return gender;
}
