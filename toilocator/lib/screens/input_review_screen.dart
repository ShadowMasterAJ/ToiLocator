import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../services/userDatabase.dart' as ud;
import '../services/getToiletInfo.dart';
import '../palette.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputReviewScreen extends StatefulWidget {
  final List toiletList;
  final int index;

  @override
  State<InputReviewScreen> createState() => _InputReviewScreenState();

  const InputReviewScreen({
    Key? key,
    required this.toiletList,
    required this.index,
  }) : super(key: key);
}

class _InputReviewScreenState extends State<InputReviewScreen>
    with AutomaticKeepAliveClientMixin<InputReviewScreen> {
  bool get wantKeepAlive => true;
  int userRating = 0; // need somehow to fetch the userrating
  String userComment = "";
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  // void updateAveUserRating(int newUserRating) {
  //   print("HELLO LOOK HERE");
  //   int updatedAveUserRating = widget.toiletList[widget.index].userRating;
  //   print(updatedAveUserRating);
  //   updatedAveUserRating =
  //       ((updatedAveUserRating * (widget.reviewCount - 1) + newUserRating) /
  //               widget.reviewCount)
  //           .ceil();
  //   updateUserRating(widget.index, updatedAveUserRating);
  // }

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

  // ignore: must_call_super
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
                          Palette.beige.shade300),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Palette.beige.shade50),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                            color: Palette.beige.shade50,
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
      body: SafeArea(
        child: Padding(
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
                SizedBox(height: 20),
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
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                  maxLength: 500,
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
                SizedBox(height: 20),
                TextButton(
                  child: Text(
                    "Submit Review",
                  ),
                  // TODO: add userID after auth
                  onPressed: () async {
                    await onPressSubmitReview();
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Palette.beige.shade50),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Palette.beige.shade300),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(
                          color: Palette.beige.shade50,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future onPressSubmitReview() async {
    Fluttertoast.showToast(
        msg: "Review submitted!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Palette.beige[300],
        textColor: Colors.white,
        fontSize: 16.0);

    userComment = myController.text;
    print('Comment: User gave review: $userComment');

    var user = await auth.FirebaseAuth.instance.currentUser;
    // ignore: unused_local_variable
    //var userData = FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
    var name = await ud.getUserName(user!.uid);
    addReview(
        DateTime.now(),
        name,
        widget.toiletList[widget.index].index.toString(),
        userRating,
        userComment);
  }
}
