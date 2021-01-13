import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:women_safety/screens/sign_in.dart';

Widget signButton({String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      title.text.white.bold.xl2.make(),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    ],
  );
}
