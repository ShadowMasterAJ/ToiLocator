import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class HomeMapScreen extends StatefulWidget {
  HomeMapScreen({Key? key}) : super(key: key);

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
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

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
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
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (value) async {
                    var addr =
                        await Geocoder.local.findAddressesFromQuery(value);

                    centerToPositionandMark(addr.first.coordinates.latitude,
                        addr.first.coordinates.longitude);
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search_sharp,
                      size: 30,
                      color: Colors.brown.shade600,
                    ),
                    filled: true,
                    fillColor: Colors.amber[100]?.withOpacity(0.9),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.brown.shade100, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    hintText: 'Enter your location',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 13, vertical: 18),
                  ),
                ),
              ),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[300],
          onPressed: getCurrentLocation,
          child: Icon(
            Icons.my_location,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
