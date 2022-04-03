import 'package:flutter/material.dart';
import 'toilet_info_card.dart';
import '../palette.dart';

class toiletCard extends StatelessWidget {
  final Map indices;
  final List toiletList;
  final int index;
  final ScrollController sc;

  const toiletCard({
    Key? key,
    required this.indices,
    required this.toiletList,
    required this.index,
    required this.sc,
  }) : super(key: key);

  List<Widget> displayStarRating(
      BuildContext context, String input, int awardInt) {
    List<Widget> childrenList = [
      Text(input)
    ]; // PROBLEM: some toilets have 6 star rating while we max at 5 stars. need to discuss.
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

  @override
  Widget build(BuildContext context) {
    double distH = 160;
    return Container(
        height: 160,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  toiletList[index].toiletName,
                                  style: Theme.of(context).textTheme.headline6,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              toiletList[index].address,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.merge(TextStyle(
                                      color: Color.fromARGB(255, 87, 87, 87))),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: displayStarRating(
                                context,
                                'Official Rating    ',
                                toiletList[index].awardInt),
                          ),
                          Row(
                            children: displayStarRating(
                                context,
                                'User Rating        ',
                                toiletList[
                                        index] // this is placeholder variable
                                    .awardInt) // i'll probably create another variable for user rating in entity class
                            ,
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                      ),
                    ),
                    Expanded(
                      child: RotatedBox(
                        quarterTurns: 5,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              //? PROBLEM: boxdeco size (the brown partition) is dependednt on the wording size. want to make it consistent for all cards.

                              //? PROBLEM 2: overflow of wording. i've already tried reducing the wording sizes but some names are too damn long. not just names, addresses also
                              //FIXED Both problems.
                              color: Palette.beige[200],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          width: distH,
                          child: Center(
                            child: Text(
                              indices[index].toString() +
                                  "m", // CHANGE TO DISTANCE
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
            InkWell(
              onTap: () {
                print("TAPT TPA TPAT PT APT APT APT PAPTPA T");
                Navigator.of(context).push(createRoute(index));
                // may fuck with the scrolling a bit ON THE MULATOR, not sure
              },
              splashColor: Palette.beige[200],
            )
          ]),
        ));
  }

  Route createRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => toiletInfoCard(
        indices: indices,
        toiletList: toiletList,
        index: index,
        displayDir: (double startLatitude, double startLongitude,
            double destinationLatitude, double destinationLongitude) {},
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
}
