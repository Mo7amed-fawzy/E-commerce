import 'dart:convert';

import 'package:e_commerce_app/app/models/user.dart';
import 'package:e_commerce_app/app/screens/home_screen.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        // showSnackBar(context, e.toString());
        MyDialogs.error(context: context, msg: e.toString());
      }
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final http.Response res = await http.post(
        Uri.parse(ApiKey.signInUrl),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (context.mounted) {
        httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences shredPreferences =
                await SharedPreferences.getInstance();

            if (context.mounted) {
              Provider.of<UserProvider>(
                context,
                listen: false,
              ).setUserFromModel(res.body);
            }

            await shredPreferences.setString(
              "my-Souq-auth-token",
              jsonDecode(res.body)['token'],
            );

            // shredPreferences.setString(
            //   Declerations.userId,
            //   jsonDecode(res.body)['user']['_id'],
            // );

            // shredPreferences.setString(
            //   Declerations.userName,
            //   jsonDecode(res.body)['user']['name'],
            // );
            if (context.mounted) {
              MyDialogs.success(
                context: context,
                msg: 'Successfully logged in',
              );

              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => false,
              );
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        // showSnackBar(context, e.toString());
        MyDialogs.error(context: context, msg: e.toString());
      }
    }
  }

  void getUserData(BuildContext context) async {
    SharedPreferences shredPreferences = await SharedPreferences.getInstance();
    String? token = shredPreferences.getString("my-Souq-auth-token");
    if (token == null || token.isEmpty) {
      shredPreferences.setString("my-Souq-auth-token", '');
      //if the token is null, it means that the user is not logged in
      return; //exit the function early since there's no valid token
    }
    try {
      var resToken = await http.post(
        Uri.parse(ApiKey.isValidToken),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': token,
        },
      );

      var res = jsonDecode(resToken.body);

      if (res['status'] == true) {
        http.Response userRes = await http.get(
          Uri.parse(ApiKey.checkToken),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'my-Souq-auth-token': token,
          },
        );
        if (context.mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUserFromModel(userRes.body);
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   HomeScreen.routeName,
          //   (route) => false,
          // );
        }

        // } else {
        //   shredPreferences.setString("my-Souq-auth-token", '');
        // }
        // if (context.mounted) {
        //   httpErrorHandling(
        //     response: res,
        //     context: context,
        //     onSuccess: () {
        //       Provider.of<UserProvider>(
        //         context,
        //         listen: false,
        //       ).setUserFromModel(res.body);
        //     },
        //   );
        // }
      }
    } catch (e) {
      if (context.mounted) {
        // MyDialogs.error(context: context, msg: e.toString());
        printHere(e.toString());
      }
    }
  }
}
