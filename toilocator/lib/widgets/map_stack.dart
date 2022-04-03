// ignore_for_file: import_of_legacy_library_into_null_safe

//just there cuz why not
import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;

//files
import 'package:toilocator/widgets/toilet_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toilocator/palette.dart';
import 'bottom_panel.dart';
import '/models/toilet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

//packages
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapStack extends StatefulWidget {
  final Function(double lat, double long) getLocFromInfo;

  const MapStack({
    Key? key,
    required this.getLocFromInfo,
  }) : super(key: key);

  @override
  State<MapStack> createState() => _MapStackState();
}

class _MapStackState extends State<MapStack> {
  LatLng _initialcameraposition =
      LatLng(1.3521, 103.8198); // 1.346150, 103.681500

  late double userLat = 1.3521, userLong = 103.8198;

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
    //downloadJSON();
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
          print("what");
          Navigator.of(context).push(createRoute(markerId));
        },
        icon: toiletIcon);
    _markers.add(marker);
    print('added marker');
  }

  // Future<void> downloadJSON() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   File downloadToFile = File('${appDocDir.path}/test.json');

  //   try {
  //     await firebase_storage.FirebaseStorage.instance
  //       .ref('toilets.json')
  //       .writeToFile(downloadToFile);
  //   // ignore: nullable_type_in_catch_clause
  //   } on firebase_core.FirebaseException catch (e) {
  //     // e.code == 'canceled'
  //     print("firebaseException");
  //   }
  // }
  void readJson() async {
    print('fetching from json...');
    final String toiletJson =
        await rootBundle.loadString('lib/data/toilets.json');
    final toiletParsed = await json.decode(toiletJson);

    // final toiletJson =
    //   await http.get('gs://cz2006-swe-43eae.appspot.com/toilets.json');
    // final toiletParsed = await json.decode(toiletJson.body);

    //firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/toilets.json');

    // storage.ref('toilets.json').getDownloadURL()
    //   .then((url) => {
    //     final toiletJson =
    //       await http.get(url);
    //     final toiletParsed = await json.decode(toiletJson.body);
    //   })
    // Directory appDocDir = await getApplicationDocumentsDirectory();

    // final String toiletJson =
    //   await rootBundle.loadString('{appDocDir.path}/toilets.json');
    // final toiletParsed = await json.decode(toiletJson);
    _toiletTemp = toiletParsed["toilets"];
    debugPrint('toiletJson.statusCode');
    for (int i = 0; i < _toiletTemp.length; i++) {
      int index = _toiletTemp[i]["index"];
      String type = _toiletTemp[i]["type"];
      String image = _toiletTemp[i]["image_link-href"];
      String address = _toiletTemp[i]["address"];
      String name = _toiletTemp[i]["toilet_name"];
      //String district = _toiletTemp[i]["district_name"];
      List coords = _toiletTemp[i]["coords"];
      int award = _toiletTemp[i]["award_int"];
      Toilet toilet = new Toilet(
          index: index,
          type: type,
          image: image,
          address: address,
          toiletName: name,
          //district: district,
          coords: coords,
          awardInt: award);
      _toiletList.add(toilet);
    }
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

  Future<LatLng> getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var long = position.longitude;
    return LatLng(lat, long);
  }

  void centerToCurrentLocation() async {
    LatLng latlng = await getCurrentLocation();
    centerToPositionandMark(latlng.latitude, latlng.longitude);
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  Route createRoute(int markerId) {
    return PageRouteBuilder(
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          toiletInfoCard(
        indices: indices,
        toiletList: _toiletList,
        index: markerId,
        getPolyLines: (polies) => setPolyLines(polies),
        lat: userLat,
        lng: userLong,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Map<PolylineId, Polyline> polylines = {};

  void setPolyLines(Map<PolylineId, Polyline> poly) {
    print('set poly points set state map stack');
    // print('1',polylines.entries);
    setState(() {
      polylines = poly;
    });
    print('Printing poly: ${poly.entries}');
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .8;
    bool entered = false;
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
            buildingsEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            markers: Set.from(_markers),
            polylines: Set<Polyline>.of(polylines.values),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: TextField(
              onSubmitted: (value) async {
                var addr = await Geocoder.local.findAddressesFromQuery(value);
                // var addr = await locationFromAddress(value);
                var lat = addr.first.coordinates.latitude;
                var long = addr.first.coordinates.longitude;
                setState(() {
                  userLat = lat;
                  userLong = long;
                });
                print('Mapstack latlng: $lat, $long');
                centerToPositionandMark(lat, long);
                entered = true;
                print(entered);
                uploadingData(value);
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
                fillColor: Palette.beige[100]?.withOpacity(0.95),
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
            // bottom drawer
            snapPoint: 0.35,
            maxHeight: _panelHeightOpen,
            minHeight: entered ? _panelHeightClosed + 185 : _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .1,
            panelBuilder: (sc) => bottomPanel(
              indices: indices,
              context: context,
              toiletList: _toiletList,
              sc: sc,
              lat: userLat,
              lng: userLong,
            ),
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
              onPressed: centerToCurrentLocation,
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

Future<void> uploadingData(value) async {
  await FirebaseFirestore.instance.collection('userInput').add({
    'location': value,
    'dateTime': DateTime.now(),
  });
  print('Comment: value added');
}
