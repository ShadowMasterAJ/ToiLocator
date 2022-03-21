import 'Gender.dart';

/// This class stores all the information of a user.
///
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

  /// Get and set method for gender stored in User
  Gender get getGender => this.gender;
  set setGender(Gender gender) => this.gender = gender;

  /// Get and set method for email stored in User
  get getEmail => this.email;
  set setEmail(email) => this.email = email;

  /// Get and set method for user id stored in User
  get getUserID => this.userID;
  set setUserID(userID) => this.userID = userID;

  /// Get and set method for password stored in User
  get getPassword => this.password;
  set setPassword(password) => this.password = password;
}
