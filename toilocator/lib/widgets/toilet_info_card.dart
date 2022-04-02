import 'package:flutter/material.dart';
import '../palette.dart';
import '../services/getToiletImageUrlList.dart';
import 'bottom_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'toilet_card.dart';

class toiletInfoCard extends StatefulWidget {
  final Map indices;
  final List toiletList;
  final int index;

  @override
  State<toiletInfoCard> createState() => _toiletInfoCardState();

  const toiletInfoCard({
    Key? key,
    required this.indices,
    required this.toiletList,
    required this.index,
  }) : super(key: key);
}

class _toiletInfoCardState extends State<toiletInfoCard> {
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

  Widget createImageList() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getToiletImagesList()
          // children: [
          //   // replace contents with list of images to parse
          //   Container(
          //       margin: EdgeInsets.all(10), width: 100, color: Colors.blue),
          //   Container(
          //       margin: EdgeInsets.all(10), width: 100, color: Colors.amber),
          //   Container(
          //       margin: EdgeInsets.all(10), width: 100, color: Colors.pink),
          //   Container(
          //       margin: EdgeInsets.all(10), width: 100, color: Colors.grey),
          //   Container(
          //       margin: EdgeInsets.all(10), width: 100, color: Colors.brown)
          // ],
        ));
  }

  List<Image> getToiletImagesList() {
    List<Image> realToiletImages = [];
    List? ImageUrlList = getToiletImageUrlList("https://www.toilet.org.sg/gallery/202/4-star-toilet-dt20-fort-canning-station") as List?;
    for (var item in ImageUrlList!) {
      realToiletImages.add(Image.network(item));
    }
    return realToiletImages; 
  }

  Widget UserReviewInfo() {
    //ListView builder probably needed, refer to bottom_panel line 93
    return Container(
        height: 160,
        child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('User Name',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1)), //needs to change i guess
                  // Padding(padding: const EdgeInsets.only(right: 160.0)),
                  Spacer(),
                  Row(children: displayStarRating(4)),
                ]),
                SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'according to all known laws of aviation,',
                      maxLines: 5,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                    )),
                // Padding(padding: const EdgeInsets.only(right: 110.0)),
                SizedBox(height: 8),
                Divider(
                    color: Color.fromARGB(255, 218, 218, 218), thickness: 1),
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius.only(
        topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0));

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            color: Palette.beige[100],
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                      child: Text(
                        // no splashcolour here
                        "Directions",
                      ),
                      onPressed: null,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Palette.beige[300] as Color),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color:
                                              Palette.beige[300] as Color)))))),
              Spacer(),
              Text(widget.indices[widget.index].toString() + "m",
                  style:
                      Theme.of(context).textTheme.headline5 // change colour too
                  ),
              // SizedBox(width: 65),
              Spacer(),
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
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Palette.beige[300] as Color),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 255, 255)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))))))
                  ])),
            ])),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Text(
                      widget.toiletList[widget.index].toiletName,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 18,
                    child: Text(
                      widget.toiletList[widget.index]
                          .address, //change colour one day
                      style: Theme.of(context).textTheme.bodyText2,
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
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        "Official Images",
                        style: Theme.of(context).textTheme.bodyText1,
                      )), // also change to grey
                  Container(height: 180, child: createImageList()),
                  Divider(
                      color: Color.fromARGB(255, 114, 114, 114),
                      thickness: 4,
                      indent: 30,
                      endIndent: 30),
                  SizedBox(height: 12),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("User Reviews",
                          style: Theme.of(context).textTheme.headline6)),
                  SizedBox(height: 6),
                  Divider(
                      color: Color.fromARGB(255, 218, 218, 218), thickness: 2),
                  SizedBox(height: 6),

                  UserReviewInfo(),
                ]))
        // )
        );
  }
}
