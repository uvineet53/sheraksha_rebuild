import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:women_safety/screens/auth/widgets/title.dart';

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
                "Commodo id nostrud quis tempor. Dolor officia cillum  dolore. Velit nostrud magna incididunt Lorem elit et veniam est sint pariatur eu consectetur Lorem occaecat.",
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
                        context.signOut();
                        Navigator.of(context).push(AuthScreen.route);
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
