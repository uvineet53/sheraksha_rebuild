import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:women_safety/screens/auth/widgets/background_painter.dart';
import 'package:women_safety/screens/auth/widgets/title.dart';

class Hometab extends StatefulWidget {
  @override
  _HometabState createState() => _HometabState();
}

class _HometabState extends State<Hometab> with SingleTickerProviderStateMixin {
  TwilioFlutter twilioFlutter;
  AnimationController _controller;

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC22703901849f7bfffb9203e85109ef87',
        authToken: '225f3937348182eb17417a4f9e65a06f',
        twilioNumber: '+12186561552');

    super.initState();
  }

  void sendSms() async {
    twilioFlutter.sendSMS(
        toNumber: '+917003850490',
        messageBody: 'Hii everyone this is a demo of\nflutter twilio sms.');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 15,
                ),
                LoginTitle(title: "Sheraksha"),
                Lottie.asset("assets/shake.json",
                    width: MediaQuery.of(context).size.width * .9),
                Text(
                  'Shake your phone \n to send alarm.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: sendSms,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Palette.orange,
                          ),
                          child: Text(
                            "SOS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Sans Serif",
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
