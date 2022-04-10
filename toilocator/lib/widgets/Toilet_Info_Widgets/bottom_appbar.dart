import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../palette.dart';
import '../../screens/auth_screen.dart';
import '../../screens/input_review_screen.dart';
import '../../services/directions.dart';

/// Builds the bottom app bar of each toilet information screen.
class BottomAppBarRow extends StatefulWidget {
  const BottomAppBarRow({
    Key? key,
    required this.toiletList,
    required this.index,
    required this.getPolyLines,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  /// The list of all toilets.
  final List toiletList;

  /// The index of the current toilet which information is to be displayed.
  final int index;

  /// The coordinates of the user's input location.
  final double lat, lng;

  /// Displays the path from the user's input location to the current toilet.
  final Function(Map<PolylineId, Polyline>) getPolyLines;

  @override
  State<BottomAppBarRow> createState() => _BottomAppBarRowState();
}

/// Creates a navigator route with animation to authentication screen.
Route createAltRoute() {
  return PageRouteBuilder(
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) =>
        AuthScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/// Styles a button.
buttonStyles(buttonColor, context) {
  return TextButton.styleFrom(
    padding: EdgeInsets.all(15),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(
          color: buttonColor as Color,
        )),
    backgroundColor: buttonColor,
  );
}

// Generates a button with padding.
Padding TextButtonGen(
    String text, Color textColor, ButtonStyle buttonStyle, onPress, context) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: TextButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: textColor,
              ),
        ),
        onPressed: onPress,
        style: buttonStyle),
  );
}

class _BottomAppBarRowState extends State<BottomAppBarRow> {
  Directions directions = Directions();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Palette.beige[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButtonGen(
            'Directions',
            Palette.beige[700] as Color,
            buttonStyles(Palette.beige[50], context),
            () async {
              await getDirections(context);
            },
            context,
          ),
          TextButtonGen(
            'Write Review...',
            Palette.beige[50] as Color,
            buttonStyles(Palette.beige[700], context),
            () {
              onPressReview(context);
            },
            context,
          ),
          TextButtonGen(
            'Back',
            Palette.beige[700] as Color,
            buttonStyles(Palette.beige[50], context),
            () => Navigator.of(context).pop(),
            context,
          ),
        ],
      ),
    );
  }

  /// Checks whether the user is already logged in when user chooses to review.
  /// If the user is not logged in, he will be navigated to the authentication page.
  /// Otherwise he will be navigated to the commenting page.
  void onPressReview(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushReplacement(createAltRoute());
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InputReviewScreen(
              index: widget.index,
              toiletList: widget.toiletList,
            ),
          ),
        ).then((value) => setState(() {}));
      }
    });
  }

  /// Generates the directions from the user's current location to the selected toilet.
  Future<void> getDirections(BuildContext context) async {
    print(
        "All LatLng: ${widget.lat}, ${widget.lng} || ${widget.toiletList[widget.index].coords[0]}, ${widget.toiletList[widget.index].coords[1]}");

    Map<PolylineId, Polyline> res = await directions.createPolylines(
        widget.lat,
        widget.lng,
        widget.toiletList[widget.index].coords[0],
        widget.toiletList[widget.index].coords[1]);
    widget.getPolyLines(res);
    Navigator.pop(context);
  }
}
