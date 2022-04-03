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

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../palette.dart';

class Directions {
  late PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  bool isLoading = false;

  createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBD6svvL_5JkLGtN9NG3V1KMx28IJ0Jiog', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.walking,
    );

    print('Results: ${result.points}');
    if (result.points.isNotEmpty) {
      print('result not empty');
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      isLoading = false;
    } else {
      isLoading = true;
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Palette.beige.shade800,
      points: polylineCoordinates,
      patterns: [PatternItem.dot],
      width: 7,
    );
    print('polyCoords $polylineCoordinates');
    print('polyline setstate: ${polyline.points}');
    polylines[id] = polyline;

    print('polylines setstate: ${polylines.entries}');
    return polylines;
  }
}
