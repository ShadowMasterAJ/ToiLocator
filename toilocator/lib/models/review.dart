import 'User.dart';
import 'Toilet.dart';

/// This class stores all the information of a review that is written by a user
/// 
class Review {
  
  DateTime dateTime = DateTime.now();
  late String userID;
  late String toiletID; // is index in Toilet class
  late int userRating;
  late String userComment;

  Review(DateTime dateTime, String userID, String toiletID, int userRating, String userComment) {
    this.dateTime = dateTime;
    this.userID = userID;
    this.toiletID = toiletID;
    this.userRating = userRating;
    this.userComment = userComment;
  }


//  /// Get and set method for datetime stored in Review
//  get getDateTime => this.dateTime;
 
//  /// Get and set method for user stored in Review
//  get getUserID => this.userID;

//  /// Get and set method for toilet stored in Review
//  get getToiletID => this.toiletID;

//  /// Get and set method for user rating stored in Review
//  get getUserRating => this.userRating;

//  /// Get and set method for user comments stored in Review
//  get getUserComment => this.userComment;

    
}
