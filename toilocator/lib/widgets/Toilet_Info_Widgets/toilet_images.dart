import 'package:flutter/material.dart';

import '../../palette.dart';
import '../../services/getToiletImageUrlList.dart';

/// Generates the toilet images in the toilet information screen.
/// Builds the horizontal-scrolling widget for all the images in a toilet.
class ToiletImages extends StatefulWidget {
  const ToiletImages({
    Key? key,
    required this.toiletList,
    required this.index,
  }) : super(key: key);

  /// The list of all toilets.
  final List toiletList;

  /// The index of the current toilet which information is to be displayed.
  final int index;

  @override
  State<ToiletImages> createState() => _ToiletImagesState();
}

class _ToiletImagesState extends State<ToiletImages> {
  List<Widget> imageList = [];
  bool isLoading = false;

  /// Converts URL links to a list of Image widgets.
  Future createImageList() async {
    List<Widget> realToiletImages = [];
    List? ImageUrlList =
        await getToiletImageUrlList(widget.toiletList[widget.index].image);
    for (var item in ImageUrlList!) {
      realToiletImages.add(Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Image.network(item, scale: 2.3)));
    }

    imageList = realToiletImages;

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Official Images",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 180,
            child: FutureBuilder(
              future: createImageList(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                (Palette.beige.shade300))))
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: imageList,
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
