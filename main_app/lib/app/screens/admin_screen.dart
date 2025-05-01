import 'package:e_commerce_app/app/screens/admin_orders_screen.dart';
import 'package:e_commerce_app/app/screens/analytics_screen.dart';
import 'package:e_commerce_app/app/screens/posts_screen.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  static const String routeName = "/admin-screen";

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double nbWidth = 42;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const AdminOrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Declarations.appBarGradient,
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Admin Penal', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Declarations.selectedNavBarColor,
        unselectedItemColor: Declarations.unselectedNavBarColor,
        backgroundColor: Declarations.backgroundColor,
        iconSize: 28,
        items: [
          getNavBottom(icon: Icons.post_add_outlined, title: 'Posts', index: 0),
          getNavBottom(
            icon: Icons.analytics_outlined,
            title: 'Analytics',
            index: 1,
          ),
          getNavBottom(
            icon: Icons.all_inbox_outlined,
            title: 'Orders',
            index: 2,
          ),
        ],
        onTap: updatePage,
      ),
    );
  }

  BottomNavigationBarItem getNavBottom({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: nbWidth,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color:
                  _page == index
                      ? Declarations.selectedNavBarColor
                      : Declarations.backgroundColor,
              width: 5,
            ),
          ),
        ),
        child: Icon(icon),
      ),
      label: title,
    );
  }
}
