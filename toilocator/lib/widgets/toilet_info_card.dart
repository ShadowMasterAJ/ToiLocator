import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Toilet_Info_Widgets/bottom_appbar.dart';
import 'Toilet_Info_Widgets/review_list.dart';
import 'Toilet_Info_Widgets/toilet_images.dart';
import 'Toilet_Info_Widgets/toilet_info.dart';
import 'Toilet_Info_Widgets/toilet_ratings_access.dart';

/// Builds the full information card of each toilet.
/// Returns a card containing all the information of the toilet.
/// Information includes name, address, ratings, images, reviews, and directions.
class toiletInfoCard extends StatefulWidget {
  /// A map containing all toilet indices as key and corresponding distance from the user location as value.
  final Map indices;

  /// The list of all toilets.
  final List toiletList;

  /// The index of the current toilet which information is to be displayed.
  final int index;

  /// The coordinates of the user's input location.
  final double lat, lng;

  /// Displays the path from the user's input location to the current toilet.
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
    required this.lng,
  }) : super(key: key);
}

class _toiletInfoCardState extends State<toiletInfoCard>
    with AutomaticKeepAliveClientMixin<toiletInfoCard> {
  bool get wantKeepAlive => true;
  int averageRating = 0;

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
