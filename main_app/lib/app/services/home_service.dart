import 'dart:convert';

import 'package:e_commerce_app/app/models/product.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
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
}
