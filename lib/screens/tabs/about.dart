import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/services/authentication_service.dart';
import 'package:women_safety/widgets/title.dart';

class Abouttab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            LoginTitle(title: "About Us"),
            Lottie.asset("assets/about.json"),
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: MaterialButton(
                      height: 55,
                      color: Palette.darkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Auth().signOut();
                      },
                      child: Text(
                        'Sign out'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
