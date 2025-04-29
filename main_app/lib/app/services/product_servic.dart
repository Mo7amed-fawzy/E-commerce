import 'dart:convert';

import 'package:e_commerce_app/app/models/product.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
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
        Uri.parse(ApiKey.getProducts),
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
        msg: 'Ex in ProductServices ${e.toString()}',
      );
    }
  }
}
