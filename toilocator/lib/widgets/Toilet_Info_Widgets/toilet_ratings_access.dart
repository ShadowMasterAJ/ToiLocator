import 'package:flutter/material.dart';

import '../../palette.dart';


class RatingsAccessibility extends StatelessWidget {
  const RatingsAccessibility({
    Key? key,
    required this.toiletList,
    required this.index,
    required this.averageRating,
  }) : super(key: key);

  final List toiletList;
  final int index;
  final int averageRating;
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  "Official Hygiene Rating    ",
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
            Spacer(),
            Row(children: displayStarRating(toiletList[index].awardInt))
          ]),
          SizedBox(height: 15),
          Row(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  "User Hygiene Rating    ",
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
            Spacer(),
            Row(children: displayStarRating((averageRating)))
          ]),
          SizedBox(height: 15),
          Row(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  "Accessibility",
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
            Spacer(),
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
        ],
      ),
    );
  }
}
