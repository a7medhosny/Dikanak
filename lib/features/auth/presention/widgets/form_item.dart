import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   const CustomTextField({super.key,required this.controller,required this.hintTitle});
  final TextEditingController controller;
  final String hintTitle;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintTitle, border: const OutlineInputBorder()),
      validator: (input) {
        if (controller.text.isNotEmpty) {
          return null;
        } else {
          return "$hintTitle must not be empty!";
        }
      },
    );
  }
}
