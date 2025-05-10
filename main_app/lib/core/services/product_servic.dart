import 'dart:convert';

import 'package:e_commerce_app/core/models/product.dart';
import 'package:e_commerce_app/core/models/user.dart';
import 'package:e_commerce_app/core/databases/remote/end_points.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    try {
      final http.Response res = await http.post(
        Uri.parse(ApiKey.rateProduct),
        headers: {
          'Content-Type': 'application/json ; charset=UTF-8',
          'my-Souq-auth-token': provider.user.token,
        },
        body: jsonEncode({'id': product.id, 'rating': rating}),
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          MyDialogs.success(
            context: context,
            msg: 'Product rated successfully',
          );
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in rateProduct ${e.toString()}',
      );
    }
  }

  void addProductToCart({
    required BuildContext context,
    required Product product,
    required double qty,
  }) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res;

      if (qty < 0) {
        res = await http.delete(
          Uri.parse('${ApiKey.removeFromCart}${product.id}'),
          headers: {
            'Content-Type': 'application/json ; charset=UTF-8',
            'my-Souq-auth-token': provider.user.token,
          },
        );
      } else {
        res = await http.post(
          Uri.parse(ApiKey.addToCart),
          headers: {
            'Content-Type': 'application/json ; charset=UTF-8',
            'my-Souq-auth-token': provider.user.token,
          },
          body: jsonEncode({'id': product.id!, 'qty': qty}),
        );
      }

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          User user = provider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          provider.setObjectUser(user);

          if (qty > 0) {
            MyDialogs.success(
              context: context,
              msg: 'Product added to cart successfully',
            );
          }
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in addProductToCart ${e.toString()}',
      );
    }
  }

  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse(ApiKey.saveUserAddress),
        headers: {
          'Content-Type': 'application/json ; charset=UTF-8',
          'my-Souq-auth-token': provider.user.token,
        },
        body: jsonEncode({'address': address}),
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          MyDialogs.success(
            context: context,
            msg: 'Address saved successfully',
          );
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in saveUserAdress ${e.toString()}',
      );
    }
  }

  void setAnOrder({
    required BuildContext context,
    required String address,
    required double totalPrice,
    required String paymentMethod,
  }) async {
    final provider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse(ApiKey.setOrder),
        headers: {
          'Content-Type': 'application/json ; charset=UTF-8',
          'my-Souq-auth-token': provider.user.token,
        },
        body: jsonEncode({
          'cart': provider.user.cart,
          'address': address,
          'totalPrice': totalPrice,
          'paymentMethod': paymentMethod,
        }),
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          MyDialogs.success(context: context, msg: 'Order placed successfully');
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in setAnOrder ${e.toString()}',
      );
    }
  }
}
