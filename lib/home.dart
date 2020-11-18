import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TwilioFlutter twilioFlutter;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Safety"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Press the button to send SMS.',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.lock_outline),
              onPressed: () {
                context.signOut();
              },
              label: Text("Sign out"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send Sms',
        child: Icon(Icons.send),
      ),
    );
  }
}
