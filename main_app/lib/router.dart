import 'package:e_commerce_app/app/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesettings) {
  switch (routesettings.name) {
    case AuthScreen.routeName:
      setting:
      routesettings;
      if (routesettings.arguments != null) {
        return MaterialPageRoute(builder: (_) => AuthScreen());
      }
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    default:
      return MaterialPageRoute(
        builder:
            (_) => const Scaffold(body: Center(child: Text('404 Not Found'))),
      );
  }
}
