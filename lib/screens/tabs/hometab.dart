import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:telephony/telephony.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/models/user.dart';

class Hometab extends StatefulWidget {
  @override
  _HometabState createState() => _HometabState();
}

class _HometabState extends State<Hometab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final telephony = Telephony.instance;
  AnimationController _controller;
  bool message;

  @override
  void initState() {
    super.initState();

    initPlatform();
  }

  Future<void> initPlatform() async {
    await telephony.requestPhoneAndSmsPermissions;
  }

  SmsSendStatusListener listener(SendStatus status) {
    if (status == SendStatus.SENT || status == SendStatus.DELIVERED) {
      Get.snackbar("Successful!", "Messages sent successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.darkBlue,
          colorText: Colors.white);
    } else {
      Get.snackbar("Unsuccessful!", "Error sending message",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.darkBlue,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    KUser user = Provider.of<KUser>(context, listen: false);
    return Center(
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
                  .collection('users')
                  .doc(user.email)
                  .collection("contacts")
                  .snapshots(),
              builder: (context, snapshot) {
                shakedetect() async {
                  if (!snapshot.hasData) {
                    print("Loading...");
                  } else {
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    int totalContacts = snapshot.data.documents.length;
                    for (var document
                        in snapshot.data.documents[totalContacts]) {
                      await telephony.sendSms(
                          to: document["number"],
                          message:
                              'Hi, I am feeling unsafe. Could you please call me back? My current location is: https://www.google.com/maps/?q=${position.latitude},${position.longitude}',
                          statusListener: listener);
                    }
                  }
                }

                ShakeDetector.autoStart(onPhoneShake: () {
                  shakedetect();
                });
                if (!snapshot.hasData) return const Text('Retrieving Data...');
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Position position =
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                          int totalContacts = snapshot.data.documents.length;

                          for (int i = 0; i < totalContacts; i++) {
                            DocumentSnapshot document =
                                snapshot.data.documents[i];
                            await telephony.sendSms(
                                statusListener: listener,
                                to: document["number"],
                                message:
                                    'Hi, I am feeling unsafe. Could you please call me back? My current location is: https://www.google.com/maps/?q=${position.latitude},${position.longitude}');
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
