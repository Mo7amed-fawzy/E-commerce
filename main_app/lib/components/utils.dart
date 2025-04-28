import 'package:flutter/material.dart';

// buildcontext to make it understand to access the main thread of the screen and build on the its context
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    ),
  );
}

String uriMethods(String uriType) {
  if (uriType == 'http') {
    return 'http://localhost:8080';
  } else if (uriType == 'mongoo') {
    return 'mongodb://localhost:27017/MyData/GroupChat';
  } else if (uriType == 'httpCinfig') {
    return 'http://192.168.1.3:8080';
  }
  //  else if (uriType == ''mongooConfig) {
  //   return 'mongodb://192.168.1.3:8080/';
  // }
  else {
    throw Exception('Unknown URI type: $uriType');
  }
}

enum UriType { http, mongoo, httpConfig, mongooConfig }

abstract class AppUri {
  static String getUri({
    required UriType uriType,
    String ip = "192.168.1.3",
    String port = '3000',
  }) {
    switch (uriType) {
      case UriType.http:
      case UriType.httpConfig:
        return 'http://${ip.isEmpty ? 'localhost' : ip}:$port';
      case UriType.mongoo:
        return 'mongodb://$ip:27017/MyData/GroupChat';
      case UriType.mongooConfig:
        return 'mongodb://$ip:$port/';
    }
  }
}

abstract class MyDialogs {
  static success({required BuildContext context, required String msg}) {
    _showCustomSnackbar(
      context: context,
      msg: msg,
      backgroundColor: Color.fromRGBO(0, 255, 0, 0.4), // الشفافية 40%
    );
  }

  static error({required BuildContext context, required String msg}) {
    _showCustomSnackbar(
      context: context,
      msg: msg,
      backgroundColor: Color.fromRGBO(255, 0, 0, 0.4), // الشفافية 40%
    );
  }

  static info({required BuildContext context, required String msg}) {
    _showCustomSnackbar(
      context: context,
      msg: msg,
      backgroundColor: Color.fromRGBO(0, 0, 255, 0.4), // الشفافية 40%
    );
  }

  static showProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
    );
  }

  static hideProgress(BuildContext context) {
    Navigator.of(context).pop();
  }

  static _showCustomSnackbar({
    required BuildContext context,
    required String msg,
    required Color backgroundColor,
  }) {
    final scaffold = ScaffoldMessenger.of(context);

    // Define the snackbar
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white)),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 6.0,

      // action: SnackBarAction(
      //   label: 'OK',
      //   textColor: Colors.white,
      //   onPressed: () {
      //     // Some action when the button is pressed
      //   },
      // ),
      // action: null, // Remove the action button if not needed
      animation: CurvedAnimation(
        parent: AnimationController(
          vsync: scaffold,
          duration: Duration(milliseconds: 100),
          // reverseDuration: Duration(milliseconds: 100),
          // animationBehavior: AnimationBehavior.values[2], ضربلي ايرور فعدد الحروف
        ),
        curve: Curves.easeInOut,
      ),
    );

    // Show the Snackbar
    scaffold.showSnackBar(snackBar);
  }
}

// void withMounted(BuildContext context, Function action) {
//   if (context.mounted) {
//     action();
//   }
// }
