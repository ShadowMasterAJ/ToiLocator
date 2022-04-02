// import 'package:flutter/material.dart';
// import 'package:google_directions_api/google_directions_api.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// class Direction {
//   final LatLng source;
//   final LatLng dest;

//   var destination;

//   var origin;
//   var key;
//   var YOUR_API_KEY='AIzaSyBD6svvL_5JkLGtN9NG3V1KMx28IJ0Jiog';

//    Direction({required this.source, required this.dest});

//    Future<http.Response> getDirections(source,dest){
//   return http.get(Uri.parse('https://maps.googleapis.com/maps/api/directions/json
//   ?destination=source
//   &origin=dest
//   &key=YOUR_API_KEY'));
// }

// }
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void getDirections(LatLng source, LatLng dest) {
  DirectionsService.init('AIzaSyBD6svvL_5JkLGtN9NG3V1KMx28IJ0Jiog');

  final directionsService = DirectionsService();

  final request = DirectionsRequest(
    origin: 'New York',
    destination: 'San Francisco',
    travelMode: TravelMode.driving,
  );

  directionsService.route(request,
      (DirectionsResult response, DirectionsStatus? status) {
    if (status == DirectionsStatus.ok) {
      // do something with successful response
    } else {
      // do something with error response
    }
  });
}
