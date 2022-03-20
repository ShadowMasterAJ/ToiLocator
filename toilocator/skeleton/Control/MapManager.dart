///

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:toilocator/palette.dart';

/// The map manager class does all the logical tasks
/// related to the map
///
class MapManager extends StatefulWidget {
  const MapManager({Key? key}) : super(key: key);

  @override
  State<MapManager> createState() => _MapManagerState();
}

class _MapManagerState extends State<MapManager> {
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

  /// Centres the map to the user's position
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

  /// When called, gets the current location of the user
  void getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var long = position.longitude;

    centerToPositionandMark(lat, long);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topStart,
        fit: StackFit.loose,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialcameraposition,
              zoom: 11.0,
            ),
            compassEnabled: true,
            zoomControlsEnabled: true,
            markers: Set.from(_markers),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: TextField(
              onSubmitted: (value) async {
                GeoData data = await Geocoder2.getDataFromAddress(
                    address: value,
                    googleMapApiKey: "AIzaSyB9M5K3SIOoxo2PBhiUsqQ4lGcksjDy-IQ");

                centerToPositionandMark(data.latitude, data.longitude);
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 20,
                    color: Palette.beige.shade900,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                suffixIcon: Icon(
                  Icons.search_sharp,
                  size: 30,
                  color: Palette.beige.shade800,
                ),
                filled: true,
                fillColor: Palette.beige[100]?.withOpacity(0.9),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.brown.shade100, width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.brown.shade100, width: 5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                hintText: 'Enter your location',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 13, vertical: 18),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 10,
            child: FloatingActionButton(
              backgroundColor: Palette.beige[200],
              onPressed: getCurrentLocation,
              child: Icon(
                Icons.my_location,
                color: Palette.beige[900],
              ),
            ),
          ),
        ]);
  }
}
