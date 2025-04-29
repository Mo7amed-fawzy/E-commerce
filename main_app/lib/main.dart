import 'package:e_commerce_app/app/screens/admin_screen.dart';
import 'package:e_commerce_app/app/screens/auth_screen.dart';
import 'package:e_commerce_app/app/services/auth_service.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'components/declarations.dart';

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

  // static void setLocale(BuildContext context, Locale newLocal) {
  //   _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
  //   state?.setLocale(newLocal);
  // }
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  // Locale? _locale;

  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Souq',
      theme: ThemeData(
        scaffoldBackgroundColor: Declarations.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: Declarations.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   // AppLocalizations.delegate, // تأكد من إضافته هنا
      //   // supportedLocales: AppLocalizations.supportedLocales,
      // ],
      // supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      // locale: _locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home:
          // Provider.of<UserProvider>(context).user.token.isNotEmpty
          //     ? const BottomBar()
          //     : const AuthScreen(),
          Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen(),
    );
  }
}
