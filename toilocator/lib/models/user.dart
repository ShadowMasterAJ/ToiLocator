import 'package:flutter/material.dart';
class User{
  final String uid;

  User({required this.uid});
}

class UserRecord {
  final String uid;
  final String userName;
  final String gender;
  final int age;

  UserRecord({required this.uid, required this.userName, required this.gender, required this.age});


  // String getUid() {
  //     return this.uid;
  // }


  // String getGender() {
  //     return this.gender;
  // }


  // int getAge(){
  //     return this.age;
  // }



 
}


//notes:when a new user registers, the firebase automatically create a unique id for that user
//when we create a new document of that user in the user collection, take that unique uid, link together



