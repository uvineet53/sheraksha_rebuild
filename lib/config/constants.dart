import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:velocity_x/velocity_x.dart';

SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

SnakeShape snakeShape = SnakeShape.circle;

ShapeBorder bottomBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(25)),
);

EdgeInsets padding = EdgeInsets.all(15);

bool showSelectedLabels = false;
bool showUnselectedLabels = false;

Color selectedColor = Colors.white;
Gradient selectedGradient = LinearGradient(colors: [Colors.red, Colors.amber]);

Color unselectedColor = Colors.blueGrey;
Gradient unselectedGradient =
    LinearGradient(colors: [Colors.red, Colors.blueGrey]);

Color containerColor;
List<Color> containerColors = [
  Color(0xFFFDE1D7),
  Color(0xFFE4EDF5),
  Color(0xFFF4E4CE),
  Color(0xFFE7EEED),
];

List<Widget> appBarList = [
  contactsTab,
  homeTab,
  aboutTab,
];

var homeTab = HStack([
  "She".text.xl4.wider.extraBold.white.make(),
  "raksha".text.xl4.wider.white.make(),
]).centered();

var contactsTab = HStack([
  "Your".text.xl4.wider.extraBold.white.make(),
  "Contacts".text.xl4.wider.white.make(),
]).centered();

var aboutTab = HStack([
  "About".text.xl4.wider.extraBold.white.make(),
  "Us".text.xl4.wider.white.make(),
]).centered();

var logoutDialogText = Text(
  "Logout",
  style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
)
    .box
    .padding(EdgeInsets.symmetric(horizontal: 12, vertical: 7))
    .black
    .rounded
    .make();
