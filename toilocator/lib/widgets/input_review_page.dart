import 'package:flutter/material.dart';
import 'package:toilocator/services/getToiletImageUrlList.dart';
import 'package:toilocator/services/getToiletInfo.dart';
import '../palette.dart';
import 'toilet_info_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InputReviewPage extends StatefulWidget {
  final List toiletList;
  final int index;
  @override
  State<InputReviewPage> createState() => _InputReviewPageState();

  const InputReviewPage({
    Key? key,
    required this.toiletList,
    required this.index,
  }) : super(key: key);
}

class _InputReviewPageState extends State<InputReviewPage> {
  int userRating = 0; // need somehow to fetch the userrating
  String userComment = "";
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget ratingBarBuilder() {
    return RatingBar.builder(
      glowColor: Color.fromARGB(255, 108, 74, 2),
      initialRating: 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star_rate_rounded,
        color: Color.fromARGB(255, 255, 198, 77),
      ),
      onRatingUpdate: (rating) {
        print(rating);
        userRating = rating.ceil();
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Palette.beige[100],
        child: Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Express your thoughts about",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  widget.toiletList[widget.index].toiletName,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: 20),
                ratingBarBuilder(),
                SizedBox(height: 20),
                TextField(
                  controller: myController,

                
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Write your comments...',
                    alignLabelWithHint: true,
                    // contentPadding:
                    //     EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  child: Text(
                    "Submit Review",
                  ),
                  // TODO: add userID after auth
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text("Review submitted!"),
                        );
                      },
                    );
                    // Widget backHome = FloatingActionButton(
                    //   child: Text("Back to home"),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //     // Navigator.of(context)
                    //     //   .push(new );
                    //   } );
                    //   setState((){});
                    


                    userComment = myController.text;
                    print('Comment: User gave review: $userComment');
                    addReview(DateTime.now(), 'userABC', widget.toiletList[widget.index].index.toString(), userRating, userComment);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 255, 255, 255)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Palette.beige[300] as Color),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// // Define a corresponding State class.
// // This class holds the data related to the Form.
// class _CommentState extends State<InputReviewPage> {
//   // Create a text controller and use it to retrieve the current value
//   // of the TextField.
//   final myController = TextEditingController();

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     myController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Retrieve Text Input'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: TextField(
//           controller: myController,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         // When the user presses the button, show an alert dialog containing
//         // the text that the user has entered into the text field.
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 // Retrieve the text the that user has entered by using the
//                 // TextEditingController.
//                 content: Text(myController.text),
//               );
//             },
//           );
//         },
//         tooltip: 'Show me the value!',
//         child: const Icon(Icons.text_fields),
//       ),
//     );
//   }
// }