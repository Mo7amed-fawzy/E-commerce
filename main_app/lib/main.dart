import 'package:e_commerce_app/app/models/user.dart';
import 'package:e_commerce_app/app/screens/auth_screen.dart';
import 'package:e_commerce_app/app/screens/home_screen.dart';
import 'package:e_commerce_app/app/services/auth_service.dart';
import 'package:e_commerce_app/components/declerations.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

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
      home:
          Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? const HomeScreen()
              : const AuthScreen(),

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
