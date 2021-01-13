import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget logoBuilder() {
  return VStack([
    Image.asset(
      "assets/logo_bg.png",
      height: 300,
    ).box.makeCentered(),
    mainTitle,
  ]).centered();
}

var mainTitle = HStack([
  "she".text.xl5.wider.extraBold.white.make(),
  "raksha".text.xl5.wider.white.make(),
]).centered();
