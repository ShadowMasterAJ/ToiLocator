/// Stores all the information of a review that is written by a user.
class Review {
  DateTime dateTime = DateTime.now();
  late String userID;
  late String toiletID; 
  late int userRating;
  late String userComment;

  Review(DateTime dateTime, String userID, String toiletID, int userRating,
      String userComment) {
    this.dateTime = dateTime;
    this.userID = userID;
    this.toiletID = toiletID;
    this.userRating = userRating;
    this.userComment = userComment;
  }
}
