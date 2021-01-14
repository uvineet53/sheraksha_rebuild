import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:women_safety/config/constants.dart';
import 'package:women_safety/config/palette.dart';
import 'package:women_safety/screens/tabs/about.dart';
import 'package:women_safety/screens/tabs/contacts.dart';
import 'package:women_safety/screens/tabs/hometab.dart';
import 'package:women_safety/services/authentication_service.dart';
import 'package:women_safety/widgets/background_painter.dart';
import 'package:women_safety/widgets/drawerWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedItemPosition = 1;
  AnimationController _controller;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  List<Widget> widgetList = [
    ContactsTab(),
    Hometab(),
    Abouttab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBarList[_selectedItemPosition],
          backgroundColor: Palette.darkBlue,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => signOutWidget(),
            ),
          ],
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
            PageView(
                onPageChanged: (index) {
                  setState(() => _selectedItemPosition = index);
                },
                controller: _pageController,
                children: widgetList),
          ],
        ),
        drawer: customDrawer(),
        bottomNavigationBar: SnakeNavigationBar.color(
          backgroundColor: Colors.white,
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
          onTap: (index) {
            setState(() {
              _selectedItemPosition = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'microphone'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'search')
          ],
        ));
  }

  signOutWidget() {
    return Get.defaultDialog(
      title: "Are You Sure?",
      content: Text("You will be logged out of the \nSheraksha App"),
      confirm: GestureDetector(
        onTap: () {
          Auth().signOut();
          Get.back();
        },
        child: logoutDialogText,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controller.dispose();
  }
}
