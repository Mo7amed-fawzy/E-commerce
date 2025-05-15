import 'package:e_commerce_app/core/databases/local/favorite_color.dart';
import 'package:e_commerce_app/core/databases/local/theme_mode.dart';
import 'package:e_commerce_app/core/dependency_injection/service_locator.dart';
import 'package:e_commerce_app/core/theme/app_theme.dart';
import 'package:e_commerce_app/features/client/presentation/screens/start/start_screen.dart';
import 'package:e_commerce_app/core/services/auth_service.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocal) {
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocal);
  }
}

class _MyAppState extends State<MyApp> {
  // final AuthService authService = AuthService();
  final authService = getIt<AuthService>();

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final provider = Provider.of<UserProvider>(context);
        final primaryColor = context.watch<PrimaryColorCubit>().state;
        final themeMode = context.watch<ThemeCubit>().state;

        return MaterialApp(
          title: 'My Souq',
          theme: getLightTheme(primaryColor),
          darkTheme: getDarkTheme(primaryColor),
          themeMode: themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
          onGenerateRoute: (settings) => generateRoute(settings),
          home:
              provider.user.token.isNotEmpty
                  ? const BottomBar()
                  : const StartScreen(),
        );
      },
    );
  }
}
