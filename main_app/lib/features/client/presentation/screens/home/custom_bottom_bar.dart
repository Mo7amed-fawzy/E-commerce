import 'package:e_commerce_app/features/client/presentation/screens/account/account_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/account/profile_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/home_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/settings.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/navigation/bottom_navigation_bar.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bar-home';

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double nbWidth = 42;

  final List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: CustomBottomNavigationBar(
        onIconPresedCallback: updatePage,
      ),
    );
  }
}
