import 'package:e_commerce_app/app/screens/account_screen.dart';
import 'package:e_commerce_app/app/screens/home_screen.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bar-home';

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double nbWidth = 42;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('cart')),
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
      //   bottomNavigationBar: CustomBottomNavigationBar(
      //     onIconPresedCallback: updatePage,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: updatePage,
        selectedItemColor: Declarations.selectedNavBarColor,
        unselectedItemColor: Declarations.unselectedNavBarColor,
        backgroundColor: Declarations.backgroundColor,
        iconSize: 30,
        items: [
          getNavButton(
            icon: Icons.home,
            title: 'Home',
            index: 0,
            nbWidth: nbWidth,
          ),
          getNavButton(
            icon: Icons.person,
            title: 'Info',
            index: 1,
            nbWidth: nbWidth,
          ),
          getNavButton(
            icon: Icons.shopping_cart,
            title: 'cart',
            index: 2,
            nbWidth: nbWidth,
            ifCart: true,
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem getNavButton({
  required IconData icon,
  required String title,
  required int index,
  required double nbWidth,
  page = 0,
  ifCart = false,
}) {
  return BottomNavigationBarItem(
    icon: Container(
      width: nbWidth,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color:
                page == index
                    ? Declarations.selectedNavBarColor
                    : Declarations.backgroundColor,
            width: 5,
          ),
        ),
      ),
      child:
          ifCart
              ? Badge(
                textColor: Colors.white,
                label: const Text('2'),
                backgroundColor: Colors.red,
                child: Icon(icon),
              )
              : Icon(icon),
    ),
    label: title,
  );
}
