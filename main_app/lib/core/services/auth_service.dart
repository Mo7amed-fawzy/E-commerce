import 'dart:convert';

import 'package:e_commerce_app/core/models/user.dart';
import 'package:e_commerce_app/features/client/presentation/screens/auth/auth_screen.dart';
import 'package:e_commerce_app/core/databases/remote/end_points.dart';
import 'package:e_commerce_app/components/error.handling.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:e_commerce_app/features/client/presentation/screens/home/custom_bottom_bar.dart';
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
      final userData = {'name': name, 'email': email, 'password': password};

      final http.Response res = await http.post(
        Uri.parse(ApiKey.signUpUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        withMounted(context, () {
          httpErrorHandling(
            response: res,
            context: context,
            onSuccess: () {
              MyDialogs.success(
                context: context,
                msg: 'Account created successfully',
              );
              // PremiumToastHelper.show(
              //   backgroundColor: Colors.green,
              //   textColor: Colors.white,
              //   message: 'Account created successfully',
              //   type: ToastType.success,
              // );
            },
          );
        });
      });
    } catch (e) {
      printHere(e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        withMounted(context, () {
          MyDialogs.error(
            context: context,
            msg: 'Exception in signUpUser:\n${e.runtimeType}\n${e.toString()}',
          );
        });
      });
      // PremiumToastHelper.show(
      //   message: 'Exception in signUpUser:\n${e.runtimeType}\n${e.toString()}',
      //   type: ToastType.error,
      // );
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences shredPreferences =
                await SharedPreferences.getInstance();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<UserProvider>(
                context,
                listen: false,
              ).setUserFromModel(res.body);
            });

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
            WidgetsBinding.instance.addPostFrameCallback((_) {
              MyDialogs.success(
                context: context,
                msg: 'Successfully logged in',
              );

              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomBar.routeName,
                (route) => false,
              );
            });
          },
        );
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // showSnackBar(context, e.toString());
        MyDialogs.error(
          context: context,

          msg: 'Ex in signInUser ${e.toString()}',
        );
      });
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUserFromModel(userRes.body);
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   HomeScreen.routeName,
          //   (route) => false,
          // );
        });
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        MyDialogs.error(
          context: context,
          msg: 'Ex in getUserData ${e.toString()}',
        );
      });
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('my-Souq-auth-token', '');
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        MyDialogs.error(context: context, msg: 'Ex in logOut ${e.toString()}');
        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthScreen.routName,
          (route) => false,
        );
      });
    }
  }

  Future<bool> getUserProf(BuildContext context) async {
    SharedPreferences shredPreferences = await SharedPreferences.getInstance();
    String? token = shredPreferences.getString("my-Souq-auth-token");
    if (token == null || token.isEmpty) {
      shredPreferences.setString("my-Souq-auth-token", '');
      return false;
    }
    List<User> usersList = [];
    try {
      var resToken = await http.get(
        Uri.parse(ApiKey.getUserInfo),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'my-Souq-auth-token': token,
        },
      );

      var res = jsonDecode(resToken.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            usersList.add(User.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        MyDialogs.error(
          context: context,
          msg: 'Ex in getUserData ${e.toString()}',
        );
      });
    }

    return false; // if token is invaled
  }
}
