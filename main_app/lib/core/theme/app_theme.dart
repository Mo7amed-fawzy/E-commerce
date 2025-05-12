import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';

ThemeData getLightTheme(Color primaryColor) {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      // color: ,
      toolbarHeight: 56,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: Colors.black),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      elevation: 10,
      selectedItemColor: primaryColor,
      unselectedItemColor: AppColors.black,
      selectedIconTheme: const IconThemeData(size: 28, color: Colors.white),
      unselectedIconTheme: const IconThemeData(
        size: 24,
        color: AppColors.black,
      ),
    ),

    cardTheme: CardTheme(
      color: AppColors.white,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // switchTheme: SwitchThemeData(
    //   thumbColor: MaterialStateProperty.resolveWith<Color>((
    //     Set<MaterialState> states,
    //   ) {
    //     if (!states.contains(MaterialState.selected)) {
    //       return Colors.black; // الدائرة لما تكون off
    //     }
    //     return Colors.red; // أو اللون اللي تحبه لما تكون on
    //   }),
    //   trackColor: MaterialStateProperty.resolveWith<Color>((
    //     Set<MaterialState> states,
    //   ) {
    //     if (!states.contains(MaterialState.selected)) {
    //       return Colors.white; // الخلفية لما تكون off
    //     }
    //     return Colors.black; // استخدم اللون الافتراضي لما تكون on
    //   }),
    // ),
  );
}

ThemeData getDarkTheme(Color primaryColor) {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarTheme(
      // color: primaryColor,
      toolbarHeight: 56,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white),
      // color: primaryColor,
    ),
    iconTheme: const IconThemeData(color: Colors.white),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkGrey,
      elevation: 10,
      selectedItemColor: Colors.black,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: IconThemeData(size: 28, color: primaryColor),
      unselectedIconTheme: const IconThemeData(size: 24, color: AppColors.grey),
    ),

    cardTheme: CardTheme(
      color: AppColors.darkColor,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

const List<Color> availablePrimaryColors = [
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.orange,
  Colors.purple,
  Colors.teal,
];
