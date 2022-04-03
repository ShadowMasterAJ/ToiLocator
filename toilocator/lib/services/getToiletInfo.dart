
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:toilocator/models/review.dart';

// can have cupertino

// DO NOT DELETE
// Must press run to initialise app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  addReview(DateTime.now(), 'user2', '0', 5, "High class toilet, enjoyed it!");
  getReviewList('0', 1);
  test('hi2');
//   helperConvertToiletJSON();

    // put this in addMarker map_stack
    // print("Comment: main running");
    // print('----------------------');
    // print('----------------------');
    // print('----------------------');
    // print('----------------------');
    // helperConvertToiletJSON(); ady converted, don't use anymore
  

}

//test
Future<void> test(String test) async {
  await FirebaseFirestore.instance.collection("userInput").add({
    'test': test
  });
}
// add a toilet instance to firebase
// doc() specifies our own index
// .set is used for the doc like to update
Future<void> addToilet(int index, String type, 
  String albumURL, String address, String toiletName, 
  List coords, int officialRating, double userRating) async {
  await FirebaseFirestore.instance.collection("toilets")
    .doc(index.toString())
    .set({
    'index': index.toString(),
    'type': type,
    'albumURL': albumURL,
    'address': address,
    'toiletName': toiletName,
    'latitude': coords[0],
    'longitude': coords[1],
    'officialRating': officialRating,
    'userRating': userRating
  })
  .then((value) => print("Toilet Added"))
  .catchError((error) => print("Failed to add toilet: $error"));
}
// convert toilet JSON format to firebase
// Future<void> helperConvertToiletJSON() async {
//   final String toiletJson =
//         await rootBundle.loadString('lib/data/toilets.json');
//   final toiletParsed = await json.decode(toiletJson);

//   List _toiletTemp = toiletParsed["toilets"];
//   //for (int i = 0; i < 1; i++) {
//   for (int i = 0; i < _toiletTemp.length; i++) {
//     int index = _toiletTemp[i]["index"];
//     String type = _toiletTemp[i]["type"];
//     String image = _toiletTemp[i]["image_link-href"];
//     String address = _toiletTemp[i]["address"];
//     String name = _toiletTemp[i]["toilet_name"];
//     List coords = _toiletTemp[i]["coords"];
//     int award = _toiletTemp[i]["award_int"];
//     addToilet(index, type, 
//       image, address, name, 
//       coords, award, 0);
//     // Toilet toilet = new Toilet(
//     //     index: index,
//     //     type: type,
//     //     image: image,
//     //     address: address,
//     //     toiletName: name,
//     //     //district: district,
//     //     coords: coords,
//     //     awardInt: award);
//     // _toiletList.add(toilet);
//     print("Comment: Successfully added toilet[$i]");
//   }
// }


// addReview for a toilet ID = index
Future<void> addReview(DateTime dateTime,
  String userID, String toiletID, 
  int userRating, String userComment) async {
    CollectionReference toilets = FirebaseFirestore.instance.collection('toilets');
    
    // try to get the doc ref given index
    await toilets.doc(toiletID).collection("reviews").add({
    'dateTime': dateTime,
    'userID': userID,
    'toiletID': toiletID,
    'userRating': userRating,
    'userComment': userComment
    });
  
}

Future<List> getReviewList(String toiletID, int numOfReview) async {
    List<Review> reviewList = [];
    CollectionReference toilets = FirebaseFirestore.instance.collection('toilets');
    toilets
      .doc(toiletID)
      .collection('reviews')
      .limit(numOfReview)
      .get()  // get all the documents
      .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc['userComment']);
          Review review = new Review(
            DateTime.parse(doc['dateTime'].toDate().toString()),
            doc['userID'],
            doc['toiletID'],
            doc['userRating'],
            doc['userComment']);
          reviewList.add(review);
        });
      });
    print(reviewList[0].dateTime);
    return reviewList;
      // THIS IS FOR ONE DOCUMENT
      // .then((DocumentSnapshot documentSnapshot) { // only for one document
      //   if (documentSnapshot.exists) {
      //     print('Comment: document exists on firebase, data: ${documentSnapshot.data()}');
      //   }
      //   else {
      //     print('Document does not exist on firebase');
      //   }
      // });

    // Map data
    // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    // try to get the doc ref given index
    // await toilets.doc(toiletID).collection("reviews").add({
    // 'dateTime': dateTime,
    // 'userID': userID,
    // 'toiletID': toiletID,
    // 'userRating': userRating,
    // 'userComment': userComment
    // });
  
}


// getReview for a toilet, maybe filter wrt ratings



// getToilet

// updateToilet

Future<void> editProduct(bool _isFavourite,String id) async {
  await FirebaseFirestore.instance
      .collection("products")
      .doc(id)
      .update({"isFavourite": !_isFavourite});
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance
      .collection("products")
      .doc(doc.id)
      .delete();
}
