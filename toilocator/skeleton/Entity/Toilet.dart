import 'dart:ffi';
import 'ToiletType.dart';
import 'package:flutter_test/flutter_test.dart';

/// This class stores all the information about all the existing toilets
///
class Toilet {
  List<double> coordinates;
  String address;
  String photoURL;
  int officialRating;
  int userRatingGeneral;
  int userRatingMale;
  int userRatingFemale;
  int userRatingDisabled;
  int userRatingNursing;
  List<ToiletType> accessibility;

  List<double> get getCoordinates => this.coordinates;

  /// Get and set method for coordinates stored in Toilet
  set setCoordinates(List<double> coordinates) =>
      this.coordinates = coordinates;
  get getCoordinates => this.coordinates;

  /// Get and set method for address stored in Toilet
  get getAddress => this.address;
  set setAddress(address) => this.address = address;

  /// Get and set method for photos (URL) stored in Toilet
  get getPhotoURL => this.photoURL;
  set setPhotoURL(photoURL) => this.photoURL = photoURL;

  /// Get and set method for official ratings stored in Toilet
  get getOfficialRating => this.officialRating;
  set setOfficialRating(officialRating) => this.officialRating = officialRating;

  /// Get and set method for user ratings stored in Toilet
  get getUserRatingGeneral => this.userRatingGeneral;
  set setUserRatingGeneral(userRatingGeneral) =>
      this.userRatingGeneral = userRatingGeneral;

  /// Get and set method for user ratings (male) stored in Toilet
  get getUserRatingMale => this.userRatingMale;
  set setUserRatingMale(userRatingMale) => this.userRatingMale = userRatingMale;

  /// Get and set method for user ratings (female) stored in Toilet
  get getUserRatingFemale => this.userRatingFemale;
  set setUserRatingFemale(userRatingFemale) =>
      this.userRatingFemale = userRatingFemale;

  /// Get and set method for user ratings (disabled) stored in Toilet
  get getUserRatingDisabled => this.userRatingDisabled;
  set setUserRatingDisabled(userRatingDisabled) =>
      this.userRatingDisabled = userRatingDisabled;

  /// Get and set method for user ratings (nursing) stored in Toilet
  get getUserRatingNursing => this.userRatingNursing;
  set setUserRatingNursing(userRatingNursing) =>
      this.userRatingNursing = userRatingNursing;

  /// Get and set method for user ratings (accessibility) stored in Toilet
  get getAccessibility => this.accessibility;
  set setAccessibility(accessibility) => this.accessibility = accessibility;
}
