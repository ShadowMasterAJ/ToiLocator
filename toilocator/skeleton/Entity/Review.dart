import 'User.dart';
import 'ToiletType.dart';
import 'Toilet.dart';

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

 final get getDateTime => this.dateTime;

 set setDateTime(final dateTime) => this.dateTime = dateTime;

 get getUser => this.user;

 set setUser( user) => this.user = user;

  get getToilet => this.toilet;

 set setToilet( toilet) => this.toilet = toilet;

  get getToiletType => this.toiletType;

 set setToiletType( toiletType) => this.toiletType = toiletType;

  get getUserRating => this.userRating;

 set setUserRating( userRating) => this.userRating = userRating;

  get getUserComment => this.userComment;

 set setUserComment( userComment) => this.userComment = userComment;

    
}