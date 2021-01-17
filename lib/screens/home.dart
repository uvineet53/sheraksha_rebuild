import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';
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
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;
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
        elevation: 0.0,
        backgroundColor: Palette.darkBlue,
        title: appBarList[_selectedItemPosition],
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.menu,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () => Auth().signOut(),
          )
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(.4),
                  offset: Offset(0, 25))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
          child: GNav(
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 900),
              tabs: [
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.purple,
                  iconColor: Colors.black,
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.user,
                  // textStyle: t.textStyle,
                  text: 'Contacts',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.pink,
                  iconColor: Colors.black,
                  textColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.amber[600],
                  iconColor: Colors.black,
                  textColor: Colors.amber[600],
                  backgroundColor: Colors.amber[600].withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.info_circle,
                  text: 'About',
                ),
              ],
              selectedIndex: _selectedItemPosition,
              onTabChange: (index) {
                // _debouncer.run(() {

                print(index);
                setState(() {
                  _selectedItemPosition = index;
                  // badge = badge + 1;
                });
                _pageController.jumpToPage(index);
                // });
              }),
        ),
      ),
    );
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
