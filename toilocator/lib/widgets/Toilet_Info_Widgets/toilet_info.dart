import 'package:flutter/material.dart';

import '../../palette.dart';

/// Builds the display for the name, address and distance of a toilet information card.
class ToiletInfo extends StatelessWidget {
  const ToiletInfo({
    Key? key,
    required this.indices,
    required this.toiletList,
    required this.index,
  }) : super(key: key);

  /// The list of all toilets.
  final List toiletList;

  /// The index of the current toilet which information is to be displayed.
  final int index;

  /// A map containing all toilet indices as key and corresponding distance from the user location as value.
  final Map indices;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                indices[index].toString() + "m",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Palette.beige[50]),
              ),
              onPressed: () {},
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(12)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.beige.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Palette.beige.shade100),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Text(
            toiletList[index].toiletName,
            maxLines: 2,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 18,
          child: Text(
            toiletList[index].address,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.merge(TextStyle(color: Color.fromARGB(255, 87, 87, 87))),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
