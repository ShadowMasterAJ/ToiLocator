import 'package:flutter/material.dart';

import '../../palette.dart';

/// Belongs to auth_card class, return the user input name
class Username_Field extends StatelessWidget {
  const Username_Field(
      {Key? key, required TextEditingController this.nameController})
      : super(key: key);
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        maxLength: 15,
        controller: nameController,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Username',
          hintStyle: TextStyle(color: Colors.black26, fontSize: 18),
          suffixIcon: Icon(
            Icons.person,
            color: Palette.beige[500],
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white54, width: 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
        ),
      ),
    );
  }
}
