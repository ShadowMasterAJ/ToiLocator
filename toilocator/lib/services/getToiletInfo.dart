import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   helperConvertToiletJSON();


// }

//test
Future<void> test(String test) async {
  await FirebaseFirestore.instance.collection("toilets").add({
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
Future<void> helperConvertToiletJSON() async {
  final String toiletJson =
        await rootBundle.loadString('lib/data/toilets.json');
  final toiletParsed = await json.decode(toiletJson);

  List _toiletTemp = toiletParsed["toilets"];
  for (int i = 0; i < 1; i++) {
  // for (int i = 0; i < _toiletTemp.length; i++) {
    int index = _toiletTemp[i]["index"];
    String type = _toiletTemp[i]["type"];
    String image = _toiletTemp[i]["image_link-href"];
    String address = _toiletTemp[i]["address"];
    String name = _toiletTemp[i]["toilet_name"];
    List coords = _toiletTemp[i]["coords"];
    int award = _toiletTemp[i]["award_int"];
    addToilet(index, type, 
      image, address, name, 
      coords, award, 0);
    // Toilet toilet = new Toilet(
    //     index: index,
    //     type: type,
    //     image: image,
    //     address: address,
    //     toiletName: name,
    //     //district: district,
    //     coords: coords,
    //     awardInt: award);
    // _toiletList.add(toilet);
    print("Comment: Successfully added toilet[$i]");
  }
}


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

