import 'package:flutter/material.dart';

class Declarations {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 109, 201),
      Color.fromARGB(255, 125, 178, 221),
    ],
    stops: [0.5, 1.0],
  );

  static const appBarGradient2 = LinearGradient(
    colors: [
      Color.fromARGB(255, 125, 178, 221),
      Color.fromARGB(255, 29, 109, 201),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(109, 141, 53, 1.0);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffdcdcf3);
  static var selectedNavBarColor = const Color.fromARGB(255, 41, 59, 185);
  static const unselectedNavBarColor = Color.fromARGB(255, 0, 0, 0);

  static const List<Map<String, String>> catImages = [
    {'title': 'Mobiles', 'image': 'assets/images/mobile.png'},
    {'title': 'Appliances', 'image': 'assets/images/appliance.png'},
    {'title': 'Fashion', 'image': 'assets/images/clothes.png'},
    {'title': 'Essentials', 'image': 'assets/images/essential.png'},
    {'title': 'Computers', 'image': 'assets/images/computer.png'},
  ];

  static const List<String> carouselImages = [
    'https://eg.jumia.is/cms/33-22/UNs/Slider-Desktop-EN_-(1).jpg',
    'https://eg.jumia.is/cms/33-22/NIVEA_SUPER_BRAND_DAY_BANNERS_JUMIA.EG_DESKTOP_SLIDER_712x384_EN.jpg',
    'https://eg.jumia.is/cms/33-22/UNs/Slider-Desktop-EN_-(2).jpg',
    'https://eg.jumia.is/cms/33-22/UNs-Deals/Summer-Appliances/EDIT/edit/Summer_Appliances-_Slider-Desktop-EN__copy_4-(2).jpg',
    'https://eg.jumia.is/cms/ja-22/games/2.gif',
  ];

  static double checkdouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.parse(value);
    } else {
      return value;
    }
  }
}
