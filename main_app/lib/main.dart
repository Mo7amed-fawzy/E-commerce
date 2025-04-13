import 'package:e_commerce_app/app/screens/auth_screen.dart';
import 'package:e_commerce_app/components/declerations.dart';
import 'package:e_commerce_app/router.dart';
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
        cardTheme: CardTheme(color: Declerations.secondaryColor),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen(),

      // Scaffold(
      // appBar: AppBar(title: Text('my souq')),
      // body: Column(
      //   children: [
      //     Center(child: const Text('demo home page')),
      //     Builder(
      //       builder: (context) {
      //         return ElevatedButton(
      //           onPressed: () {
      //             Navigator.pushNamed(context, AuthScreen.routeName);
      //           },
      //           child: const Text('go to auth screen'),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
