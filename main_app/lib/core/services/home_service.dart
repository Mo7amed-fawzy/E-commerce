import 'dart:convert';

import 'package:e_commerce_app/core/models/order.dart';
import 'package:e_commerce_app/core/models/product.dart';
import 'package:e_commerce_app/core/databases/remote/end_points.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  Future<List<Product>> getCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('${ApiKey.getProducts}?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': provider.user.token,
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
              // fromJson json > map > dart object
              // jsonDecode json > map
              // jsonEncode map > object
            );
          }
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in getCategoryProducts ${e.toString()} ',
      );
    }
    return productList;
  }

  Future<List<Product>> searchForProducts({
    required BuildContext context,
    required String txt,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse(ApiKey.search + txt),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productsList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in searchForProducts ${e.toString()} ',
      );
    }
    return productsList;
  }

  Future<List<Product>> dealOfProducts({required BuildContext context}) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse(ApiKey.deelOfTheDay),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': provider.user.token,
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in dealOfTheDay ${e.toString()} ',
      );
    }

    return productList;
  }

  Future<List<Order>> getMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response res = await http.get(
        Uri.parse(ApiKey.myOrders),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      // showSnackBar(context, e.toString());
      MyDialogs.error(
        context: context,
        msg: 'Ex in getMyOrders ${e.toString()} ',
      );
    }
    return orderList;
  }
}
