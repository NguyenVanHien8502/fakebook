import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final dynamic? controller;
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;

  const MyTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          fillColor: Colors.white10,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
