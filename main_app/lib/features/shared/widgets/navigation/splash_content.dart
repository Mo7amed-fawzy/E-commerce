import 'package:e_commerce_app/core/func/responsive.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key, required this.text, required this.image});

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          "My SOUQ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36, context),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(text, textAlign: TextAlign.center),
        const Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265, context),
          width: getProportionateScreenWidth(235, context),
        ),
      ],
    );
  }
}
