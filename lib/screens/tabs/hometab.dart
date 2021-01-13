import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:shake/shake.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/widgets/title.dart';

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
        authToken: 'bf63a51c94549efb05d5ab262eef366a',
        twilioNumber: '+12186561552');

    super.initState();
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
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('contacts')
                        .snapshots(),
                    builder: (context, snapshot) {
                      shakedetect() async {
                        Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        int totalContacts = snapshot.data.documents.length;

                        for (int i = 0; i < totalContacts; i++) {
                          DocumentSnapshot document =
                              snapshot.data.documents[i];
                          twilioFlutter
                              .sendSMS(
                                  toNumber: document["number"],
                                  messageBody:
                                      'Hi, I am feeling unsafe. Could you please call me back? My current location is: https://www.google.com/maps/?q=${position.latitude},${position.longitude}')
                              .then((value) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Message Sent"),
                            ));
                          }).catchError((e) =>
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Message Not Sent"),
                                  )));
                        }
                      }

                      ShakeDetector detector =
                          ShakeDetector.autoStart(onPhoneShake: () {
                        shakedetect();
                      });
                      if (!snapshot.hasData)
                        return const Text('Retrieving Data...');
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);
                                int totalContacts =
                                    snapshot.data.documents.length;

                                for (int i = 0; i < totalContacts; i++) {
                                  DocumentSnapshot document =
                                      snapshot.data.documents[i];
                                  twilioFlutter
                                      .sendSMS(
                                          toNumber: document["number"],
                                          messageBody:
                                              'Hi, I am feeling unsafe. Could you please call me back? My current location is: https://www.google.com/maps/?q=${position.latitude},${position.longitude}')
                                      .then((value) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Message Sent"),
                                    ));
                                  }).catchError((e) => Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text("Message Not Sent"),
                                          )));
                                }
                              },
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
                      );
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
