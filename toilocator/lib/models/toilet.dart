import 'package:toilocator/models/review.dart';

class Toilet {
  final int index;
  final String type;
  final String image;
  final String address;
  final String toiletName;
  final List coords;
  final int awardInt;
  var userRating = 0;
  List<Review> reviewList = [];

  Toilet({
    required this.index,
    required this.type,
    required this.image,
    required this.address,
    required this.toiletName,
    required this.coords,
    required this.awardInt,
  });

  void updateUserRating(int newUserRating) {
    userRating = newUserRating;
  }
}
