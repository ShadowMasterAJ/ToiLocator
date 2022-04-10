import 'package:flutter/material.dart';

import '../../palette.dart';

///Belongs to auth_card class, return the user input password
class Password_Field extends StatefulWidget {
  const Password_Field(
      {Key? key, required TextEditingController this.passwordController})
      : super(key: key);
  final TextEditingController passwordController;

  @override
  State<Password_Field> createState() => _Password_FieldState();
}

class _Password_FieldState extends State<Password_Field> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: _isObscure,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.black26, fontSize: 18),
          suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Palette.beige[500]),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              }),
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
