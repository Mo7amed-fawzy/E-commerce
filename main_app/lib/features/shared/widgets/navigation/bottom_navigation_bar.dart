import 'dart:core';

import 'package:badges/badges.dart' as custom_badge;
import 'package:e_commerce_app/features/shared/widgets/navigation/bottom_curved_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/user_provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onIconPresedCallback;

  const CustomBottomNavigationBar({
    super.key,
    required this.onIconPresedCallback,
  });

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _xController;
  late AnimationController _yController;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );
    _yController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );
    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;
    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    const buttonCount = 5.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _icon(
    IconData icon,
    bool isEnable,
    int index, {
    bool ifCart = false,
    int cartCount = 0,
  }) {
    final theme = Theme.of(context);
    final bottomBarTheme = theme.bottomNavigationBarTheme;

    return Expanded(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: () => _handlePressed(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
            height: isEnable ? 40 : 20,
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  isEnable
                      ? bottomBarTheme.selectedItemColor ?? theme.primaryColor
                      : bottomBarTheme.backgroundColor ?? theme.canvasColor,
              boxShadow: [
                BoxShadow(
                  color:
                      isEnable
                          ? theme.colorScheme.surface.withOpacity(0.1)
                          : Colors.transparent,
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(5, 5),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: Opacity(
              opacity: isEnable ? _yController.value : 1,
              child:
                  ifCart
                      ? custom_badge.Badge(
                        badgeContent: Text(
                          cartCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        badgeStyle: const custom_badge.BadgeStyle(
                          badgeColor: Colors.red,
                        ),
                        child: Icon(
                          icon,
                          color:
                              isEnable
                                  ? bottomBarTheme.selectedIconTheme?.color ??
                                      Colors.white
                                  : bottomBarTheme.unselectedItemColor ??
                                      theme.iconTheme.color,
                        ),
                      )
                      : Icon(
                        icon,
                        color:
                            isEnable
                                ? bottomBarTheme.selectedIconTheme?.color ??
                                    Colors.white
                                : bottomBarTheme.unselectedItemColor ??
                                    theme.iconTheme.color,
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    const inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      painter: BackgroundCurvePainter(
        _xController.value * MediaQuery.of(context).size.width,
        Tween<double>(
          begin: Curves.easeInExpo.transform(_yController.value),
          end: inCurve.transform(_yController.value),
        ).transform(_yController.velocity.sign * 0.5 + 0.5),
        Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
            Theme.of(context).colorScheme.surface,
      ),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) width = 400.0;
    return width;
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    widget.onIconPresedCallback(index);
    setState(() {
      _selectedIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(
      _indexToPosition(index) / MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 620),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      _yController.animateTo(1.0, duration: const Duration(milliseconds: 1200));
    });
    _yController.animateTo(0.0, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<UserProvider>().user.cart.length;
    final appSize = MediaQuery.of(context).size;
    const height = 60.0;

    return SizedBox(
      width: appSize.width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: _buildBackground(),
          ),
          Positioned(
            right: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _icon(Icons.home_outlined, _selectedIndex == 0, 0),
                _icon(Icons.person_outline_outlined, _selectedIndex == 1, 1),
                _icon(
                  Icons.shopping_cart_outlined,
                  _selectedIndex == 2,
                  2,
                  cartCount: cartCount,
                  ifCart: true,
                ),
                _icon(Icons.account_circle_outlined, _selectedIndex == 3, 3),
                _icon(Icons.settings_outlined, _selectedIndex == 4, 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
