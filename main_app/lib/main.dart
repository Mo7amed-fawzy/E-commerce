import 'package:e_commerce_app/components/declerations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my Souq',
      theme: ThemeData(
        scaffoldBackgroundColor: Declerations.backgroundColor,
        cardTheme: const ColorScheme.light(
          primary: Declerations.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('my souq')),
        body: Center(child: const Text('demo home page')),
      ),
    );
  }
}
