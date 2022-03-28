// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toilocator/palette.dart';
import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/services.dart';
import '/models/toilet.dart';

class MapStack extends StatefulWidget {
  const MapStack({Key? key}) : super(key: key);

  @override
  State<MapStack> createState() => _MapStackState();
}

class _MapStackState extends State<MapStack> {
  late BitmapDescriptor toiletIcon;
  LatLng _initialcameraposition =
      LatLng(1.3521, 103.8198); // 1.346150, 103.681500
  late GoogleMapController _controller;

  List<Marker> _markers = [];
  List _toiletTemp = [];
  List<Toilet> _toiletList = [];
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

  void retrieveIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'lib/assets/toilet_marker.png')
        .then((onValue) {
      toiletIcon = onValue;
    });
  }

  void addToiletMarker(int markerId, double lat, double long) async {
    retrieveIcon();
    LatLng _position = LatLng(lat, long);
    var marker = Marker(
        markerId: MarkerId(_position.toString()),
        position: _position,
        onTap: () {
          print("toilet is tapped!"); // future function to push info here
        },
        icon: toiletIcon);
    _markers.add(marker);
  }

  Future<void> readJson() async {
    final String toiletJson =
        await rootBundle.loadString('lib/data/toilets.json');
    final toiletParsed = await json.decode(toiletJson);
    setState(() {
      _toiletTemp = toiletParsed["data"];

      for (int i = 0; i < _toiletTemp.length; i++) {
        int index = _toiletTemp[i]["index"];
        String type = _toiletTemp[i]["type"];
        String image = _toiletTemp[i]["image_link-href"];
        String address = _toiletTemp[i]["address"];
        String name = _toiletTemp[i]["toilet_name"];
        String district = _toiletTemp[i]["district_name"];
        List coords = _toiletTemp[i]["coords"];
        int award = _toiletTemp[i]["award_int"];
        var toilet = new Toilet(
            index: index,
            type: type,
            image: image,
            address: address,
            toiletName: name,
            district: district,
            coords: coords,
            awardInt: award);
        _toiletList.add(toilet);
      }
    });
  }

  void markNearestToilets(double lat, double long) {
    List indices = calculateNearestToilets(lat, long);
    for (int i = 0; i < indices.length; i++) {
      int index = indices[i];
      List coords = _toiletList[index].coords;
      addToiletMarker(index, coords[0], coords[1]);
    }
  }

  List calculateNearestToilets(double lat, double long) {
    List _acceptedIndices = [];
    for (int i = 0; i < _toiletList.length; i++) {
      // calculation by haversine
      double targetCoord_lat = _toiletList[i].coords[0];
      double targetCoord_long = _toiletList[i].coords[1];
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((targetCoord_lat - lat) * p) / 2 +
          c(lat * p) *
              c(targetCoord_lat * p) *
              (1 - c((targetCoord_long - long) * p)) /
              2;
      double dist = 12742 * asin(sqrt(a)); // in KM
      if (dist < 1) {
        // CURRENT THRESHOLD AT 1KM
        _acceptedIndices.add(i);
      }
    }
    return _acceptedIndices;
  }

  void centerToPositionandMark(double lat, double long) {
    readJson();
    print("Latitude: $lat and Longitude: $long");

    setState(() => _initialcameraposition = LatLng(lat, long));
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _initialcameraposition,
        zoom: 15,
      ),
    ));
    _markers.clear();
    markNearestToilets(lat,
        long); // there is a problem with the position of this function. i can't fix it

    addMarker();
    // run the marknesrestest toilets here
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
