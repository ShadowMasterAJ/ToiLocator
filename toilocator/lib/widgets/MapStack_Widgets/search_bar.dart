import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';

import '../../palette.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.centerToPositionandMark,
    required this.uploadingData,
  }) : super(key: key);

  final Function(double, double) centerToPositionandMark;
  final Function(String) uploadingData;
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late double userLat, userLong;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) async {
        try {
          var addr = await Geocoder.local.findAddressesFromQuery(value);
          var lat = addr.first.coordinates.latitude;
          var long = addr.first.coordinates.longitude;
          setState(() {
            userLat = lat;
            userLong = long;
          });
          print('Mapstack latlng: $lat, $long');
          widget.centerToPositionandMark(lat, long);
          widget.uploadingData(value);
        } catch (PlatformException) {
          Fluttertoast.showToast(
              msg: "Invalid Location, please try again!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Color.fromARGB(255, 99, 99, 99),
              textColor: Colors.white,
              fontSize: 16.0);
        }
        // var addr = await locationFromAddress(value);
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
            borderSide: BorderSide(color: Colors.brown.shade100, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown.shade100, width: 5),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        hintText: 'Enter your location',
        contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 18),
      ),
    );
  }
}
