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

 Gender get getGender => this.gender;

 set setGender(Gender gender) => this.gender = gender;

  get getEmail => this.email;

 set setEmail( email) => this.email = email;

  get getUserID => this.userID;

 set setUserID( userID) => this.userID = userID;

  get getPassword => this.password;

 set setPassword( password) => this.password = password;

  



}