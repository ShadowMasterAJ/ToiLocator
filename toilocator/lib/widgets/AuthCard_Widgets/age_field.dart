import 'package:flutter/material.dart';

class Age_Field extends StatelessWidget {
  const Age_Field(
      {Key? key, required TextEditingController this.ageController})
      : super(key: key);
  final TextEditingController ageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        // textAlignVertical: TextAlignVertical.top,
        controller: ageController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
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
          hintText: 'Age',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
