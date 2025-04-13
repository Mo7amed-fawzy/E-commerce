import 'package:flutter/material.dart';

abstract class Declerations {
  static var appBarGradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 201, 29, 126),
      const Color.fromARGB(255, 221, 125, 187),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(109, 141, 53, 1.0);
  //fromRGBO => Red, Green, Blue and alpha
  static const backgroundColor = Colors.white;

  static const Color greyBackgroundColor = Color(0xffdcdcf3);
  //HEX color code

  static var selectedNavBarColor = const Color.fromARGB(255, 41, 59, 185);
  static const unselectedNavBarColor = Color.fromARGB(255, 0, 0, 0);
}
