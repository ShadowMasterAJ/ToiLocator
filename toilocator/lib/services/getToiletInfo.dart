import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  uploadingData("iPad", "https://google.com", true);


}


Future<void> uploadingData(String _productName,
    String _imageUrl, bool _isFavourite) async {
  await FirebaseFirestore.instance.collection("toilet").add({
    'productName': _productName,
    'imageUrl': _imageUrl,
    'isFavourite': _isFavourite,
  });
}

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

