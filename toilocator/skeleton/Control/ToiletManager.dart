import 'package:flutter/material.dart';
import 'Toilet.dart';

class ToiletManager {
  var toiletList = new List(); //TODO:Check what happened to this
  ToiletManager(Toilet toiletList) {
    this.toiletList = toiletList;
  }

  /// This method updates the toilet information
  void updateToiletInfo() {}

  /// This method retrieves the whole toilet list
  void gettoiletList() {}

  /// This method retrieves the number of toilets in the toilet list
  void getToiletNum() {}

  /// This method obtains the review of a toilet
  void getToiletReview() {}

  /// This method adds a toilet to the toilet list
  void addToilet() {}

  /// This method deletes a toilet in the toilet list
  void deleteToilet() {}

  /// This method displays the nearby toilets around the user's location
  void displayNearbyToilet() {}

  /// This method displays the features of a toilet
  void displayToiletFeatures() {}
}
