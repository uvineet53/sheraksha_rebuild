import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:women_safety/config/constants.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/screens/tabs/about.dart';
import 'package:women_safety/screens/tabs/contacts.dart';
import 'package:women_safety/screens/tabs/hometab.dart';

import 'auth/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItemPosition = 1;

  List<Widget> widgetList = [
    ContactsTab(),
    Hometab(),
    Abouttab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgetList[_selectedItemPosition],
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: SnakeShape.circle,
          shape: bottomBarShape,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          snakeViewColor: Palette.darkBlue,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: Palette.lightBlue,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: _selectedItemPosition,
          onTap: (index) => setState(() => _selectedItemPosition = index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'microphone'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'search')
          ],
        ));
  }
}
