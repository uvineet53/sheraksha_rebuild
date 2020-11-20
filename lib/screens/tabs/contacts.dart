import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/screens/auth/widgets/background_painter.dart';
import 'package:women_safety/screens/auth/widgets/title.dart';
import 'package:women_safety/screens/contactInfo/contactForm.dart';

class ContactsTab extends StatefulWidget {
  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ContactSave(),
        )),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                LoginTitle(title: "Contacts"),
                Lottie.asset("assets/contact.json"),
                Container(
                  child: Container(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
