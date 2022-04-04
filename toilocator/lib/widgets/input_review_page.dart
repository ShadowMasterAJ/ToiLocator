import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toilocator/screens/home_map_screen.dart';
import 'package:toilocator/services/getToiletImageUrlList.dart';
import 'package:toilocator/services/getToiletInfo.dart';
import '../palette.dart';
import 'package:toilocator/widgets/map_stack.dart';
import '/models/toilet.dart';
import '/widgets/toilet_info_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:toilocator/services/userDatabase.dart' as ud;
class InputReviewPage extends StatefulWidget {
  final int reviewCount;
  final List toiletList;
  final int index;
  @override
  State<InputReviewPage> createState() => _InputReviewPageState();

  const InputReviewPage({
    Key? key,
    required this.reviewCount,
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
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          contentPadding: EdgeInsets.only(top: 10.0),
                          content: Container(
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          "Review submitted!",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ]),
                                SizedBox(height: 30),
                                InkWell(
                                  child: Container(
                                    width: 400,
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    decoration: BoxDecoration(
                                      color: Palette.beige[500],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(32.0),
                                          bottomRight: Radius.circular(32.0)),
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          // Navigator.popUntil(
                                          //     context,
                                          //     ModalRoute.withName(
                                          //         '/toiletInfo'));
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeMapScreen()),
                                          ).then((value) => setState(() {}));
                                        },
                                        child: Text(
                                          "Return",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
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
                    //  Navigator.of(context).pushReplacement(
                    //  MaterialPageRoute(builder: (context) => HomeMapScreen()));

                    userComment = myController.text;
                    print('Comment: User gave review: $userComment');

                    
                    var user = await auth.FirebaseAuth.instance.currentUser;
                    // ignore: unused_local_variable
                    //var userData = FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
                    var name= await ud.getUserName(user!.uid);
                    addReview(DateTime.now(), name, widget.toiletList[widget.index].index.toString(), userRating, userComment);
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
