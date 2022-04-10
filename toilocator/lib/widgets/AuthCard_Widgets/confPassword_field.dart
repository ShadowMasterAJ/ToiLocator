import 'package:flutter/material.dart';

import '../../palette.dart';

/// Builds a card containing the user's confirmed password in the authentication card.
class ConfPassword_Field extends StatefulWidget {
  const ConfPassword_Field(
      {Key? key, required TextEditingController this.confirmController})
      : super(key: key);
  final TextEditingController confirmController;

  @override
  State<ConfPassword_Field> createState() => _ConfPassword_FieldState();
}

class _ConfPassword_FieldState extends State<ConfPassword_Field> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: widget.confirmController,
        obscureText: isObscure,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Palette.beige[500]),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              }),
          isDense: true,
          hintText: 'Confirm Password',
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
      ),
    );
  }
}
