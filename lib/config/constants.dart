import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

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
