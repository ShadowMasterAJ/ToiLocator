import 'package:flutter/material.dart';
import 'Review.dart';

class ReviewManager {
  Review reviewArray: ArrayList<Review>;
  ReviewManager(User user, Toilet toilet, ToiletType toiletType, int userRating, String userComment) {
    Review review = Review(user, toilet, toiletType, userRating, userComent);
    reviewArray.add(review);
  }
  void updateReview() {}
  void createReview() {}
  void deleteReview() {}
  void searchReview() {}
  void displayReview() {}
  double calculateAveRating() {}
}


