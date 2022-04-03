// import 'package:flutter/material.dart';
// import 'package:google_directions_api/google_directions_api.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// class Direction {
//   final LatLng source;
//   final LatLng dest;

//   var destination;

//   var origin;
//   var key;
//   var YOUR_API_KEY = 'AIzaSyBD6svvL_5JkLGtN9NG3V1KMx28IJ0Jiog';

//   Direction({required this.source, required this.dest});

//   Future<http.Response> getDirections(source, dest) async {
//     final url = Uri.parse(
//         "https://maps.googleapis.com/maps/api/directions/json?destination=$source&origin=$dest&key=$YOUR_API_KEY&mode=walking");

//     final response = await http.get(url);
//     Map<String, List> dirData = {};
//     final Set<Polyline> polyline = {};
//   }
// }

import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  static void getDirections(dynamic dest) {
    DirectionsService.init('AIzaSyBD6svvL_5JkLGtN9NG3V1KMx28IJ0Jiog');

    final directionsService = DirectionsService();
    // double lat = source.latitude;
    // double lng = source.longitude;
    final request = DirectionsRequest(
      origin: 'Marina Bay Sands',
      destination: dest,
      travelMode: TravelMode.walking,
    );
    directionsService.route(request,
        (DirectionsResult response, DirectionsStatus? status) {
      if (status == DirectionsStatus.ok) {
        print(response.routes![0].legs![0].distance!.text);
        
      } else {
        print(response.errorMessage);
      }
    });
  }
}
