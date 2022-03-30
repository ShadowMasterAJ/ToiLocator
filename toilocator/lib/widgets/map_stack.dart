// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:ffi';
import 'dart:typed_data';

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
  LatLng _initialcameraposition =
      LatLng(1.3521, 103.8198); // 1.346150, 103.681500
  late GoogleMapController _controller;

  Map indices = {}; // key = index of toilet, value = distance
  List<Marker> _markers = [];
  List _toiletTemp = [];
  List<Toilet> _toiletList = [];
  late BitmapDescriptor toiletIcon;

  final double _initFabHeight = 131.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 118.0;

  bool infoDrawerPopup = false;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
    retrieveIcon();
    readJson();
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

  void addToiletMarker(int markerId, double lat, double long) {
    LatLng _position = LatLng(lat, long);
    Marker marker = Marker(
        markerId: MarkerId(_position.toString()),
        position: _position,
        onTap: () {
          setState(() {
            infoDrawerPopup = true;
          });
          print("toilet is tapped!"); // future function to push info here
        },
        icon: toiletIcon);
    _markers.add(marker);
    print('added marker');
  }

  void readJson() async {
    print('fetching from json...');
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
        Toilet toilet = new Toilet(
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
    print('fetched from json');
  }

  void markNearestToilets(double lat, double long) {
    indices.clear();
    indices = calculateNearestToilets(lat, long);
    for (int k in indices.keys) {
      int index = k;
      List coords = _toiletList[index].coords;
      addToiletMarker(index, coords[0], coords[1]);
      print('marked nearest toilets');
    }
    print(indices);
  }

  Map calculateNearestToilets(double lat, double long) {
    Map nearestToiletList = {};
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
        nearestToiletList[i] = (dist * 1000).ceil();
      }
    }
    print('calcd nearest toilets');
    print(nearestToiletList);
    Map nearestToiletListSorted = Map.fromEntries(
        nearestToiletList.entries.toList()
          ..sort((e1, e2) => e1.value.compareTo(e2.value)));
    return nearestToiletListSorted;
  }

  void centerToPositionandMark(double lat, double long) {
    print('fetched in function');
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
    print('addMarker called');

    markNearestToilets(lat, long);
    print('centered and marked');
    for (int i = 0; i < _markers.length; i++) {
      print(_markers[i].markerId.toString());
    }
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
    final List<int> indexList = List<int>.generate(indices.length,
        (int indexPointer) => indices.keys.elementAt(indexPointer),
        growable: true);
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
                child: Text("Recommended toilets in the area...",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
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
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: ListView.builder(
                itemCount: indexList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int indexPointer) {
                  return toiletCard(
                      indices: indices,
                      toiletList: _toiletList,
                      index: indexList[indexPointer]);
                },
              )),
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
            bottom: _fabHeight,
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
  final Map indices;
  final List toiletList;
  final int index;

  const toiletCard({
    Key? key,
    required Map this.indices,
    required List this.toiletList,
    required int this.index,
  }) : super(key: key);

  List<Widget> displayStarRating(
      BuildContext context, String input, int awardInt) {
    List<Widget> childrenList = [
      Text(input)
    ]; // PROBLEM: some toilets have 6 star rating while we max at 5 stars. need to discuss.
    for (int i = 0; i < awardInt; i++) {
      childrenList.add(Icon(Icons.star_rate_rounded,
          color: Color.fromARGB(255, 255, 198, 77)));
    }
    for (int i = 0; i < 5 - awardInt; i++) {
      childrenList.add(Icon(Icons.star_rate_rounded,
          color: Color.fromARGB(255, 211, 211, 211)));
    }
    return childrenList;
  }

  List<Widget> childrenCreator(BuildContext context, int index) {
    // i had half a mind to name this method the 'babymaker'
    final childrenList = <Widget>[];
    childrenList.add(Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            toiletList[index].toiletName,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Text(
          toiletList[index].address,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Spacer(),
        Row(
          children: displayStarRating(
              context, 'Official Rating    ', toiletList[index].awardInt),
        ),
        Row(
          children: displayStarRating(
              context,
              'User Rating        ',
              toiletList[index] // this is placeholder variable
                  .awardInt) // i'll probably create another variable for user rating in entity class
          ,
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Icon(
                Icons.wheelchair_pickup,
                color: Palette.beige[300],
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.baby_changing_station)
            ],
          ),
        ),
      ],
    ));
    childrenList.add(Spacer());
    childrenList.add(VerticalDivider(
      color: Colors.white,
      width: 0,
    ));
    childrenList.add(Expanded(
      child: RotatedBox(
        quarterTurns: 5,
        child: Container(
          height: 42,
          decoration: BoxDecoration(
              // PROBLEM: boxdeco size (the brown partition) is dependednt on the wording size. want to make it consistent for all cards.
              // PROBLEM 2: overflow of wording. i've already tried reducing the wording sizes but some names are too damn long. not just names, addresses also
              color: Palette.beige,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          width: 155,
          child: Center(
            child: Text(
              indices[index].toString() + "m", // CHANGE TO DISTANCE
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ),
    ));
    print(childrenList);
    print("help");
    return childrenList;
  }

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
            children: childrenCreator(context, index),
          ),
        ),
      ),
    );
  }
}
