import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

final String uid;
DatabaseService({ required this.uid });

// collection reference
 final CollectionReference usersCollection = Firestore.instance.collection('users');

//favourite toilets may change to a list, add in age, map of reviews and toilets
 Future<void> updateUserData(bool gender, String favToilets) async {
 return await usersCollection.document(uid).setData({
 'gender': gender,
 'favourite toilets' : favToilets
 });
 }


//  Future<DocumentReference> addReview(String message) {
//     if (_loginState != ApplicationLoginState.loggedIn) {
//       throw Exception('Must be logged in');
//     }

//     return FirebaseFirestore.instance
//         .collection('guestbook')
//         .add(<String, dynamic>{
//       'review': message,
//       'timestamp': DateTime.now().millisecondsSinceEpoch,
//       'name': FirebaseAuth.instance.currentUser!.displayName,
//       'userId': FirebaseAuth.instance.currentUser!.uid,
//     });
//   }


//set up another stream to notify any document changes in the database
}