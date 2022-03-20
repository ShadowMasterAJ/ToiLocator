import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';

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

  set setCoordinates(List<double> coordinates) =>
      this.coordinates = coordinates;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getPhotoURL => this.photoURL;

  set setPhotoURL(photoURL) => this.photoURL = photoURL;

  get getOfficialRating => this.officialRating;

  set setOfficialRating(officialRating) => this.officialRating = officialRating;

  get getUserRatingGeneral => this.userRatingGeneral;

  set setUserRatingGeneral(userRatingGeneral) =>
      this.userRatingGeneral = userRatingGeneral;

  get getUserRatingMale => this.userRatingMale;

  set setUserRatingMale(userRatingMale) => this.userRatingMale = userRatingMale;

  get getUserRatingFemale => this.userRatingFemale;

  set setUserRatingFemale(userRatingFemale) =>
      this.userRatingFemale = userRatingFemale;

  get getUserRatingDisabled => this.userRatingDisabled;

  set setUserRatingDisabled(userRatingDisabled) =>
      this.userRatingDisabled = userRatingDisabled;

  get getUserRatingNursing => this.userRatingNursing;

  set setUserRatingNursing(userRatingNursing) =>
      this.userRatingNursing = userRatingNursing;

  get getAccessibility => this.accessibility;

  set setAccessibility(accessibility) => this.accessibility = accessibility;
}
