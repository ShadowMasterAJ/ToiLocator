// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toilocator/palette.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'dart:typed_data';

class MapStack extends StatefulWidget {
  const MapStack({Key? key}) : super(key: key);

  @override
  State<MapStack> createState() => _MapStackState();
}

class _MapStackState extends State<MapStack> {
  LatLng _initialcameraposition = LatLng(1.346150, 103.681500);
  late GoogleMapController _controller;

  List<Marker> _markers = [];
  final double _initFabHeight = 131.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 118.0;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

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

  void addToiletMarker(int markerId, double lat, double long) async {
    final Uint8List customIcon = await networkImageToByte(
        "https://assets.stickpng.com/images/580b57fcd9996e24bc43c39c.png");
    LatLng _position = LatLng(lat, long);
    var marker = Marker(
        markerId: MarkerId(_position.toString()),
        position: _position,
        onTap: () {
          print("toilet is tapped!");
        },
        icon: BitmapDescriptor.fromBytes(customIcon));
  }

  // void markNearestToilets() {

  // }

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

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            indent: 10,
            endIndent: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                child: Text("Recommended Toilets in the area...",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.wc,
                size: 40,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return toiletCard();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .8;

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
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: TextField(
              onSubmitted: (value) async {
                var addr = await Geocoder.local.findAddressesFromQuery(value);

                centerToPositionandMark(addr.first.coordinates.latitude,
                    addr.first.coordinates.longitude);
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
          SlidingUpPanel(
            snapPoint: 0.35,
            // minHeight: 100.0,
            // maxHeight: MediaQuery.of(context).size.height * 0.8,

            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .1,
            panelBuilder: (sc) => _panel(sc),
            // collapsed: ListView(
            //   children: <Widget>[
            //     SizedBox(
            //       height: 12.0,
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Container(
            //           width: 30,
            //           height: 5,
            //           decoration: BoxDecoration(
            //               color: Colors.grey[300],
            //               borderRadius:
            //                   BorderRadius.all(Radius.circular(12.0))),
            //         ),
            //       ],
            //     ),
            //     Divider(),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Container(
            //           width: 300,
            //           child: Text("Recommended Toilets in the area...",
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //               style: Theme.of(context).textTheme.headline4),
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Icon(
            //           Icons.wc,
            //           size: 40,
            //           color: Colors.black,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),

            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
          Positioned(
            bottom: _fabHeight, // TODO: need to make this relative to drawer
            right: 10,
            child: FloatingActionButton(
              tooltip: "Center to your location",
              elevation: 10,
              backgroundColor: Palette.beige[200],
              onPressed: getCurrentLocation,
              child: Icon(
                Icons.gps_fixed,
                size: 25,
                color: Palette.beige[900],
              ),
            ),
          ),
        ]);
  }
}

class toiletCard extends StatelessWidget {
  const toiletCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 155,
        // width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Toilet Name",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    'Address of Toilet',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text('Official Rating    '),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                    ],
                  ),
                  Row(
                    children: [
                      Text('User Rating        '),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                      Icon(Icons.star_half_rounded),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.wheelchair_pickup),
                        Icon(Icons.baby_changing_station)
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              VerticalDivider(
                color: Colors.black,
                width: 0,
              ),
              Expanded(
                child: RotatedBox(
                  quarterTurns: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Palette.beige,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    width: 155,
                    child: Center(
                      child: Text(
                        '300m',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
