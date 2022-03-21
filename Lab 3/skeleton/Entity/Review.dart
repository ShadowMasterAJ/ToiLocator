import 'User.dart';
import 'ToiletType.dart';
import 'Toilet.dart';

/// This class stores all the information of a review that is written by a user
/// 
class Review {
  final dateTime = DateTime.now();
  User user;
  Toilet toilet;
  ToiletType toiletType;
  int userRating;
  String userComment;

  Review(User user, Toilet toilet, ToiletType toiletType, int userRating, String userComment) {
    this.user = user;
    this.toilet = toilet;
    this.toiletType = toiletType;
    this.userRating = userRating;
    this.userComment = userComment;
  }

 /// Get and set method for datetime stored in Review
 final get getDateTime => this.dateTime;
 set setDateTime(final dateTime) => this.dateTime = dateTime;
 
 /// Get and set method for user stored in Review
 get getUser => this.user;
 set setUser( user) => this.user = user;

 /// Get and set method for toilet stored in Review
 get getToilet => this.toilet;
 set setToilet( toilet) => this.toilet = toilet;

 /// Get and set method for toilet stored in Review
 get getToiletType => this.toiletType;
 set setToiletType( toiletType) => this.toiletType = toiletType;

 /// Get and set method for user rating stored in Review
 get getUserRating => this.userRating;
 set setUserRating( userRating) => this.userRating = userRating;

 /// Get and set method for user comments stored in Review
 get getUserComment => this.userComment;
 set setUserComment( userComment) => this.userComment = userComment;

    
}