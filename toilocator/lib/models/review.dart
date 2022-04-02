class Review {
  final String toiletID;
  final String userID;
  final String reviewID;
  final String text;
  final int rating;
  var dateTime = DateTime.now();

  Review(
      {required this.toiletID,
      required this.userID,
      required this.reviewID,
      required this.text,
      required this.rating,
      required this.dateTime});
}
