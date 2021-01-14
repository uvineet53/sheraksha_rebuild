import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customDrawer() {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            "assets/logo_bg.png",
            color: Colors.grey,
          ),
        ),
        HStack([
          "she".text.xl5.wider.extraBold.gray700.make(),
          "raksha".text.xl5.wider.gray700.make(),
        ]).centered(),
        SizedBox(
          height: 35,
        ),
        Text(
          "\"She believed\n she could\n and so she did\"",
          textAlign: TextAlign.left,
          style: GoogleFonts.greatVibes(
              textStyle: TextStyle(
            fontSize: 44,
          )),
        ).box.makeCentered(),
        SizedBox(
          height: 25,
        ),
        "Cortexity"
            .text
            .xl4
            .wider
            .bold
            .white
            .makeCentered()
            .box
            .p8
            .black
            .rounded
            .margin(EdgeInsets.symmetric(horizontal: 20))
            .make(),
        SizedBox(
          height: 15,
        ),
        "Contact Us".text.xl3.wider.bold.makeCentered()
      ],
    ),
  );
}
