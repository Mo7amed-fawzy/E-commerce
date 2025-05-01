import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_app/app/models/order.dart';
import 'package:e_commerce_app/app/models/product.dart';
import 'package:e_commerce_app/app/models/sales.dart';
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

  Future<List<Order>> getAllOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response res = await http.get(
        Uri.parse(ApiKey.getAllProducts),
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

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse(ApiKey.updateOrderStatus),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': order.id, 'status': status}),
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

  Future<Map<String, dynamic>> getTotalSales(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    double totalSales = 0;
    double totalOrders = 0;
    double totalProducts = 0;
    try {
      http.Response res = await http.get(
        Uri.parse(ApiKey.getAdminAnalytics),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'my-souq-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          var result = jsonDecode(res.body);
          totalSales = Declarations.checkdouble(result['totalSales'] ?? 0.0);
          totalOrders = Declarations.checkdouble(result['totalOrders'] ?? 0.0);
          totalProducts = Declarations.checkdouble(
            result['totalProducts'] ?? 0.0,
          );
          sales = [
            Sales(
              label: 'Mobiles',
              totalSale: Declarations.checkdouble(result['catMobiles'] ?? 0.0),
            ),
            Sales(
              label: 'Appliances',
              totalSale: Declarations.checkdouble(
                result['catAppliances'] ?? 0.0,
              ),
            ),
            Sales(
              label: 'Fashion',
              totalSale: Declarations.checkdouble(result['catFashion'] ?? 0.0),
            ),
            Sales(
              label: 'Essentials',
              totalSale: Declarations.checkdouble(
                result['catEssentials'] ?? 0.0,
              ),
            ),
            Sales(
              label: 'Computers',
              totalSale: Declarations.checkdouble(
                result['catComputers'] ?? 0.0,
              ),
            ),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalSales': totalSales,
      'totalOrders': totalOrders,
      'totalProducts': totalProducts,
    };
  }
}
