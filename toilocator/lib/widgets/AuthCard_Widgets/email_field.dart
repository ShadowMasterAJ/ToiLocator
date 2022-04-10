import 'package:flutter/material.dart';

/// Belongs to auth_card class, return the user input email
class Email_Field extends StatelessWidget {
  const Email_Field(
      {Key? key, required TextEditingController this.emailController})
      : super(key: key);
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.black26, fontSize: 18),
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
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
