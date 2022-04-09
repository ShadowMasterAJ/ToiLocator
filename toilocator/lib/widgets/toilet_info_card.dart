import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Toilet_Info_Widgets/bottom_appbar.dart';
import 'Toilet_Info_Widgets/review_list.dart';
import 'Toilet_Info_Widgets/toilet_images.dart';
import 'Toilet_Info_Widgets/toilet_info.dart';
import 'Toilet_Info_Widgets/toilet_ratings_access.dart';

class toiletInfoCard extends StatefulWidget {
  final Map indices;
  final List toiletList;
  final int index;
  final double lat, lng;
  final Function(Map<PolylineId, Polyline>) getPolyLines;

  @override
  State<toiletInfoCard> createState() => _toiletInfoCardState();

  const toiletInfoCard({
    Key? key,
    required this.indices,
    required this.toiletList,
    required this.index,
    required this.getPolyLines,
    required this.lat,
    required this.lng, //TODO: if user doesnt enter
  }) : super(key: key);
}

class _toiletInfoCardState extends State<toiletInfoCard>
    with AutomaticKeepAliveClientMixin<toiletInfoCard> {
  bool get wantKeepAlive => true;
  int averageRating = 0;

  // Route createRoute(int index, List toiletList) {
  //   return PageRouteBuilder(
  //     settings: RouteSettings(name: "/inputReview"),
  //     pageBuilder: (
  //       context,
  //       animation,
  //       secondaryAnimation,
  //     ) =>
  //         InputReviewScreen(
  //       index: index,
  //       toiletList: toiletList,
  //     ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarRow(
        index: widget.index,
        toiletList: widget.toiletList,
        getPolyLines: widget.getPolyLines,
        lat: widget.lat,
        lng: widget.lng,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToiletInfo(
                indices: widget.indices,
                index: widget.index,
                toiletList: widget.toiletList,
              ),
              SizedBox(height: 30),
              RatingsAccessibility(
                  toiletList: widget.toiletList,
                  index: widget.index,
                  averageRating: averageRating),
              SizedBox(height: 30),
              ToiletImages(toiletList: widget.toiletList, index: widget.index),
              SizedBox(height: 15),
              ReviewList(
                index: widget.index,
                toiletList: widget.toiletList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
