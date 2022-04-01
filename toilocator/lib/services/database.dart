// import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

final String? uid;
DatabaseService({this.uid });

// // collection reference
final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');


 Future<void> updateUserData(String gender, int age, List<dynamic> favToilets) async {
 return await usersCollection.doc(uid).set({
 'gender': gender,
 'age': age,
 'favourite toilets' : favToilets
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
