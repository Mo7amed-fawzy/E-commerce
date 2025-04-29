import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_app/app/models/product.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void saveProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double qty,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloud = CloudinaryPublic('dqygzdi4g', 'my_souq');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloud.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: category),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        price: price,
        qty: qty,
        category: category,
        images: imageUrls,
      );

      http.Response res = await http.post(
        Uri.parse(ApiKey.adminAddProduct),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          MyDialogs.info(
            context: context,
            msg: 'your product added successfully',
          );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in saveProduct ${e.toString()}',
      );
    }
  }

  Future<List<Product>> getAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse(ApiKey.adminGetProducts),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
              // fromJson بتتعامل مع سترنج
              // بس المشكلة ان jsonDecode(res.body) بتتعامل مع dynamic وانا عاوز اخصصها
              // فهشفرها الاول jsonEncode وبعدين استعمل عليها الfromjson
            );
          }
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in getAllProducts ${e.toString()}',
      );
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(ApiKey.adminAddProduct),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      MyDialogs.error(
        context: context,
        msg: 'Ex in deleteProduct ${e.toString()}',
      );
    }
  }
}
