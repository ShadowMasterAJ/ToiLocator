import 'package:flutter/material.dart';
class User{
  String uid;

  User({required this.uid});
}

class UserRecord {
  String? uid;
  String? userName;
  String? userEmail;
  String? gender;
  int? age;

  UserRecord({ this.uid, this.userName, this.userEmail, this.gender, this.age});


factory UserRecord.fromMap(map) {
    return UserRecord(
      uid: map['uid'],
      userName: map['userName'],
      userEmail: map['email'],
      gender: map['gender'],
      age: map['age'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': userEmail,
      'gender': gender,
      'age': age,
    };
  }

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



