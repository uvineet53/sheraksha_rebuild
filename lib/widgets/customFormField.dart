import 'package:flutter/material.dart';

Widget customFormField(
    {bool isPassword = false,
    TextEditingController controller,
    String hint,
    validator}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey[800],
    ),
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(fontSize: 22, color: Colors.white54),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white38),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}
