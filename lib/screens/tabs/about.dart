import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/services/authentication_service.dart';

class Abouttab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Lottie.asset("assets/about.json", height: Get.height * .55),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Palette.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "With all the measures taken around the world to keep your loved ones in touch, we keep the loved one closer than before no matter how far they might be.",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                minWidth: double.infinity,
                height: 55,
                color: Palette.darkBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Auth().signOut();
                },
                child: Text(
                  'Sign out'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
