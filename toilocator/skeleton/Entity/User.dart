import 'Gender.dart';
class User {
  Gender gender = Gender.MALE;
  String email = "";
  String userID = "";
  String password = "";


  User(Gender gender, String email, String userID, String password) {
    this.gender = gender;
    this.email = email;
    this.userID = userID;
    this.password = password;
  }



}