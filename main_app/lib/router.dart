import 'package:e_commerce_app/core/models/order.dart';
import 'package:e_commerce_app/core/models/product.dart';
import 'package:e_commerce_app/features/admin/presentation/add_products.dart';
import 'package:e_commerce_app/features/client/presentation/screens/account/profile_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/settings.dart';
import 'package:e_commerce_app/features/client/presentation/screens/orders/address_screen.dart';
import 'package:e_commerce_app/features/admin/presentation/admin_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/auth/auth_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/category/category_deal_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/home_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/orders/order_details_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/product/product_details_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/search/search_screen.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/custom_bottom_bar.dart';
import 'package:e_commerce_app/features/client/presentation/setting/change_password_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case ProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileScreen(),
      );
    case ChangePasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChangePasswordScreen(),
      );
    case SettingsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SettingsScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(category: category),
      );
    case SearchScreen.routeName:
      var txt = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchTxt: txt),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(product: product),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(order: order),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder:
            (_) => const Scaffold(body: Center(child: Text('No data here :('))),
      );
  }
}
