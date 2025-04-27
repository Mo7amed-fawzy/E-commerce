import 'package:e_commerce_app/app/models/user.dart';
import 'package:e_commerce_app/components/declerations.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: 'user',
        token: '',
      );
      final http.Response res = await http.post(
        Uri.parse(ApiKey.signUpUrl),

        // result of middleware
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: user.toJson(),
      );
      if (context.mounted) {
        httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            MyDialogs.success(
              context: context,
              msg: 'Account created successfully ',
            );
            // showSnackBar(context, 'Account created successfully');
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   HomeScreen.routeName,
            //   (route) => false,
            // );
          },
        );
      }

      //   jsonEncode(<String, String>{
      //     'email': email,
      //     'password': password,
      //     'name': name,
      //   }),
      // );
      // if (res.statusCode == 200) {
      //   return User.fromJson(res.body);
      // } else {
      //   // If the server did not return a 201 CREATED response,
      //   // then throw an exception.
      //   throw Exception('Failed to sign up user');
      // }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
