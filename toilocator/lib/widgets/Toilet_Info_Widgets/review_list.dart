import 'package:flutter/material.dart';

import '../../palette.dart';
import '../../services/getToiletInfo.dart';

/// Builds a list of reviews for each toilet of the toilet information card.
class ReviewList extends StatefulWidget {
  const ReviewList({
    Key? key,
    required this.toiletList,
    required this.index,
  }) : super(key: key);

  /// The list of all toilets.
  final List toiletList;

  /// The index of the current toilet which information is to be displayed.
  final int index;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  /// The list of all review widgets.
  List<Widget> reviewList = [];
  int averageRating = 0;

  /// Creates a list of all reviews of a toilet, retrieved from FireBase.
  Future createReviewList(BuildContext context) async {
    int sumRating = 0;

    List<Widget> tempReviewList = [];
    print(
        'Comment: createReviewList: index is ${widget.toiletList[widget.index].index.toString()}');
    List? textReviewList = await getReviewList(
        widget.toiletList[widget.index].index.toString(), 100);

    try {
      for (var item in textReviewList) {
        print(
            'Comment: createReviewList: item in textReviewList ${item.userComment}');
        tempReviewList.add(UserReviewInfo(
            item.userID, item.userRating, item.userComment, context));
        sumRating += item.userRating as int;
        print('Comment: Review widgets added to textReviewList');
      }
    } catch (e) {
      throw ('Something went wrong getting item in textReviewList, $e');
    }
    reviewList = tempReviewList;
    var reviewCount = reviewList.length;
    averageRating = (sumRating / reviewCount).ceil();
    return Future.value();
  }

  /// Builds the user-reviewed rating of a toilet.
  /// Returns a list of 5 stars, with the number of stars shaded yellow according to the rating.
  List<Widget> displayStarRating(int awardInt) {
    List<Widget> childrenList = [];
    if (awardInt > 5) {
      awardInt = 5;
    }
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

  /// Creates a container of user review information.
  /// Includes the user-reviewed rating.
  Widget UserReviewInfo(
      String userID, int userRating, String userComment, BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Row(children: [
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(userID,
                  style: Theme.of(context).textTheme.subtitle1?.merge(
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
          Padding(padding: const EdgeInsets.only(right: 160.0)),
          Spacer(),
          Row(children: displayStarRating(userRating)),
        ]),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Text(
              userComment,
              maxLines: 10,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
            )),
        Divider(
          color: Color.fromARGB(255, 218, 218, 218),
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 00),
      child: Column(
        children: [
          Text("User Reviews", style: Theme.of(context).textTheme.headline6),
          Divider(thickness: 2, indent: 20, endIndent: 20),
          SizedBox(height: 6),
          Container(
            height: 300,
            child: FutureBuilder(
              future: createReviewList(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting &&
                    reviewList.length != 0) {
                  print('reviewlist has data');
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 10.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: reviewList,
                    ),
                  );
                } else if (snapshot.connectionState !=
                        ConnectionState.waiting &&
                    reviewList.length == 0) {
                  print('Comment: no reviews');
                  return Column(
                    children: [
                      Image.asset(
                        'lib/assets/no_toilets.png',
                        width: 100,
                        height: 100,
                      ),
                      Text('No reviews, waiting for yours!',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  //else {
                  print('connecting');
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              (Palette.beige[300] as Color))));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
