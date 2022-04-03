import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toilocator/services/getToiletImageUrlList.dart';
import 'package:toilocator/services/getToiletInfo.dart';
import '../palette.dart';
import 'bottom_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'input_review_page.dart';
import 'toilet_card.dart';
import 'map_stack.dart';
import '../services/directions.dart';

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

class _toiletInfoCardState extends State<toiletInfoCard> {
  List<Widget> imageList = [];
  bool isLoading = false;
  Directions directions = new Directions();

  List<Widget> reviewList = [];
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

  Future createImageList() async {
    // Convert URL links to realToiletImage

    List<Widget> realToiletImages = [];
    List? ImageUrlList =
        await getToiletImageUrlList(widget.toiletList[widget.index].image);
    for (var item in ImageUrlList!) {
      realToiletImages.add(Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Image.network(item, scale: 2.3)));
    }

    imageList = realToiletImages;

    return Future.value();
  }

  // Create a list of review widgets
  Future createReviewList() async {
    // addReview(DateTime.now(), 'user1', widget.toiletList[widget.index].index.toString(), 2, 'Pee everywhere');
    // Can delete this afterards

    List<Widget> tempReviewList = [];
    print(
        'Comment: createReviewList: index is ${widget.toiletList[widget.index].index.toString()}');
    List? textReviewList = await getReviewList(
        widget.toiletList[widget.index].index.toString(), 100);
    // 2nd parameter is the limit of numOfReview
    // List? textReviewList = [];
    // try {
    //   textReviewList = await getReviewList('0', 2);
    // } catch (e) {
    //   throw ('createReviewList: Something went wrong getting review list, $e');
    // }

    // print("Comment: createReviewList textReviewList: ${textReviewList[0].userComment}");
    try {
      for (var item in textReviewList) {
        print(
            'Comment: createReviewList: item in textReviewList ${item.userComment}');
        tempReviewList.add(
            UserReviewInfo(item.userID, item.userRating, item.userComment));
      }
    } catch (e) {
      throw ('Something went wrong getting item in textReviewList, $e');
    }

    reviewList = tempReviewList;

    return Future.value();
  }

  Widget UserReviewInfo(String userID, int userRating, String userComment) {
    //ListView builder probably needed, refer to bottom_panel line 93
    return Container(
      // height: 80,
      // child: Card(
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
        // SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Text(
              userComment,
              maxLines: 10,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
            )),
        // Padding(padding: const EdgeInsets.only(right: 110.0)),
        // SizedBox(height: 8),
        Divider(color: Color.fromARGB(255, 218, 218, 218), thickness: 1),
      ]),
    );
    // );
  }

  Route createRoute(int index, List toiletList) {
    return PageRouteBuilder(
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          InputReviewPage(index: index, toiletList: toiletList),
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

  // late PolylinePoints polylinePoints;
  // List<LatLng> polylineCoordinates = [];
  // Map<PolylineId, Polyline> polylines = {};

  // createPolylines(
  //   double startLatitude,
  //   double startLongitude,
  //   double destinationLatitude,
  //   double destinationLongitude,
  // ) async {
  //   polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyBD6svvL_5JkLGtN9NG3V1KMx28IJ0Jiog', // Google Maps API Key
  //     PointLatLng(startLatitude, startLongitude),
  //     PointLatLng(destinationLatitude, destinationLongitude),
  //     travelMode: TravelMode.walking,
  //   );

  //   print('Results: ${result.points}');
  //   if (result.points.isNotEmpty) {
  //     print('result not empty');
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = true;
  //     });
  //   }

  //   PolylineId id = PolylineId('poly');
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Palette.beige.shade800,
  //     points: polylineCoordinates,
  //     patterns: [PatternItem.dot],
  //     width: 7,
  //   );
  //   print('polyCoords $polylineCoordinates');
  //   setState(() {
  //     print('polyline setstate: ${polyline.points}');
  //     polylines[id] = polyline;

  //     print('polylines setstate: ${polylines.entries}');
  //   });
  //   widget.getPolyLines(polylines);
  // }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            bottomNavigationBar: BottomAppBar(
                color: Palette.beige[100],
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          child: Text(
                            // no splashcolour here
                            "Directions",
                          ),
                          onPressed: () async {
                            print('directions pressed');

                            print(
                                "All LatLng: ${widget.lat}, ${widget.lng} || ${widget.toiletList[widget.index].coords[0]}, ${widget.toiletList[widget.index].coords[1]}");

                            Map<PolylineId, Polyline> res =
                                await directions.createPolylines(
                                    widget.lat,
                                    widget.lng,
                                    widget.toiletList[widget.index].coords[0],
                                    widget.toiletList[widget.index].coords[1]);
                            widget.getPolyLines(res);
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Palette.beige[300] as Color),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      // Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () => Navigator.of(context).push(createRoute(
                              widget.index,
                              widget
                                  .toiletList)), // ONLY IF USER IS AUTHENTICATED
                          child: Text(
                            "Write Review...",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 255, 255)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Palette.beige[300] as Color),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Palette.beige[300] as Color),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                            TextButton(
                              child: Text(
                                "Back",
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Palette.beige[300] as Color),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 255, 255, 255)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                    ])),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Container(
                    //       width: 30,
                    //       height: 5,
                    //       decoration: BoxDecoration(
                    //           color: Colors.grey[300],
                    //           borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    //     ),
                    //   ],
                    // ),
                    Divider(
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          child: Text(
                            widget.indices[widget.index].toString() + "m",
                          ),
                          onPressed: null,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(12)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 255, 255)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 179, 152, 112)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 179, 152, 112)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Text(
                        widget.toiletList[widget.index].toiletName,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline5,
                        // style: TextStyle(fontFamily: "Avenir"),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 18,
                      child: Text(
                        widget.toiletList[widget.index].address,
                        style: Theme.of(context).textTheme.bodyText2?.merge(
                            TextStyle(color: Color.fromARGB(255, 87, 87, 87))),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              "Official Hygiene Rating    ",
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 110.0)),
                      Row(
                          children: displayStarRating(
                              widget.toiletList[widget.index].awardInt))
                    ]),
                    SizedBox(height: 15),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              "User Hygiene Rating    ",
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 110.0)),
                      Row(
                          children: displayStarRating(widget
                              .toiletList[widget.index]
                              .awardInt)) //placeholder value
                    ]),
                    SizedBox(height: 15),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              "Accessibility    ",
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 110.0)),
                      Row(children: [
                        SizedBox(
                          width: 60,
                        ),
                        Icon(
                          Icons.wheelchair_pickup,
                          color: Palette.beige[300],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.baby_changing_station)
                      ])
                    ]),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Official Images",
                        style: Theme.of(context).textTheme.bodyText1?.merge(
                            TextStyle(
                                color: Color.fromARGB(255, 118, 118, 118))),
                      ),
                    ),
                    SizedBox(
                      // height: 180,

                      child: FutureBuilder(
                        future: createImageList(),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? Center(child: CircularProgressIndicator())
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: imageList,
                                  ),
                                );
                        },
                      ),
                    ),
                    Divider(
                        color: Color.fromARGB(255, 142, 142, 142),
                        thickness: 4,
                        indent: 30,
                        endIndent: 30),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 00),
                      child: Column(
                        children: [
                          Text("User Reviews",
                              style: Theme.of(context).textTheme.headline6),
                          SizedBox(height: 8),
                          Divider(
                              color: Color.fromARGB(255, 218, 218, 218),
                              thickness: 2),
                          SizedBox(height: 6),
                          Container(
                            height: 300,
                            child: FutureBuilder(
                              future: createReviewList(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 10.0, 0.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: reviewList,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          );
  }
}
