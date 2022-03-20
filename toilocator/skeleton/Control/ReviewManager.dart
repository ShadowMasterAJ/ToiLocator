import 'package:flutter/material.dart';
import 'Review.dart';


/// Manages user interaction with reviews, as well as application calculation of review settings
class ReviewManager {
  Review reviewArray: ArrayList<Review>;
  ReviewManager(User user, Toilet toilet, ToiletType toiletType, int userRating, String userComment) {
    Review review = Review(user, toilet, toiletType, userRating, userComent);
    reviewArray.add(review);
  }

  /// For the user to update their own review, only if they have a review recorded already
  void updateReview() {}

  /// For the user to create a new review
  void createReview() {}

  /// For the user to delete a past review, only if they have a review recorded already  
  void deleteReview() {}

  /// For the user to search through their past reviews
  void searchReview() {}

  /// Displays the reviews on the screen
  void displayReview() {}

  /// Calculates the average rating of a toilet given the toilet
  double calculateAveRating(Toilet toilet) {}
}


