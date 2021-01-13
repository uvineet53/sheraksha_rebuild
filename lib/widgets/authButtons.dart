import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:women_safety/screens/sign_in.dart';
import 'package:women_safety/screens/sign_up.dart';

Widget registerUnderline(bool isSignUp) {
  return HStack([
    !isSignUp
        ? "No Account? ".text.lg.color(Colors.grey).make()
        : "Have an Account? ".text.lg.color(Colors.grey).make(),
    GestureDetector(
      onTap: () => Get.offAll(isSignUp ? SignInForm() : SignUpForm()),
      child: isSignUp
          ? "Login Here     ".text.color(Colors.grey).bold.lg.make()
          : "Register Here     ".text.color(Colors.grey).bold.lg.make(),
    )
  ]).centered();
}

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
