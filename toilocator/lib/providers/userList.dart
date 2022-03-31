import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toilocator/models/userRecord.dart';


//leave it first, may not be used
//in profile page, nest with a new widget userlist?
class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

     final userRecord = Provider.of<List<UserRecord>>(context);
    userRecord.forEach((userRecord) {
      print(userRecord.gender);
      print(userRecord.age);
      print(userRecord.favToilets);
    });


    return Container(
      
    );
  }
}