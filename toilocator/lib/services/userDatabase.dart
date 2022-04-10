import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  final String uid;
// final String userName;
// final String gender;
// final int age;
  UserDatabaseService(this.uid);

// // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<bool> checkIfUserExists(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot.exists;
  }

  Future<void> addNewUser(
      String userName, String userEmail, String gender, int age) {
    // Call the user's CollectionReference to add a new user
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

//  // user list from snapshot
//   List<UserRecord> _userListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc){
//       //print(doc.data);
//       return UserRecord(
//         gender: doc.data()['gender'] ?? '',
//         age: doc.data()['age'] ?? 0,
//         favToilets: doc.data()['favToilets'] ?? [],
//       );
//     }).toList();
//   }

// //set up another stream to notify any document changes in the database
// // get user records stream
//   Stream<List<UserRecord>> get userRecord {
//     return usersCollection.snapshots().map(_userListFromSnapshot);
//   }
}

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
