import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';


class UserDatabaseService {

final String uid;
// final String userName;
// final String gender;
// final int age;
UserDatabaseService(this.uid);

// // collection reference
final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');


Future<bool> checkIfUserExists(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot.exists;
  }

Future<void> addNewUser(String userName, String gender, int age) {
      // Call the user's CollectionReference to add a new user
      return usersCollection
          .add({
            // 'uid': uid, // John Doe
            'userName': userName,
            'gender': gender, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

}

 Future<void> updateUser(String uid, String userName, String gender, int age) {
  return usersCollection
    .doc(uid)
    .update({ 'userName':userName,
              'gender': gender,
              'age': age})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}



 Future<void> readUserData(String uid){
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
