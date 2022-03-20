import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:toilocator/palette.dart';

class MapManager extends StatefulWidget {
  const MapManager({Key? key}) : super(key: key);

  @override
  State<MapManager> createState() => _MapManagerState();
}

class _MapStackState extends State<MapStack> {
  LatLng _initialcameraposition = LatLng(1.3521, 103.8198);
  late GoogleMapController _controller;

  List<Marker> _markers = [];

  void addMarker() {
    _markers.add(
      Marker(
          markerId: MarkerId(_initialcameraposition.toString()),
          draggable: false,
          onTap: () {
            print(_initialcameraposition.toString());
          },
          position: _initialcameraposition),
    );
  }
}

void centerToPositionandMark(double lat, double long) {
    print("Latitude: $lat and Longitude: $long");

    setState(() => _initialcameraposition = LatLng(lat, long));
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _initialcameraposition,
        zoom: 15,
      ),
    ));
    _markers.clear();

    addMarker();
  }

  void getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var long = position.longitude;

    centerToPositionandMark(lat, long);
  }