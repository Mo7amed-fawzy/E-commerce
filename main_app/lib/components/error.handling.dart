import 'dart:convert';

import 'package:e_commerce_app/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 201: // for sign up
      onSuccess();

      break;
    case 200: // for sign in
      onSuccess();

      break;
    case 400:
      // showSnackBar(
      //   context,
      //   'Response 400 is ${jsonDecode(response.body)['msg2']}',
      // );
      MyDialogs.info(
        context: context,
        msg: 'Response 400 is ${jsonDecode(response.body)['msg2']}',
      );
      break;
    case 401:
      throw Exception('Unauthorized: ${response.body}');
    case 403:
      throw Exception('Forbidden: ${response.body}');
    case 500:
      // showSnackBar(
      //   context,
      //   '(Response 500) User Validtion failed: ${jsonDecode(response.body)['error']}',
      // );
      MyDialogs.error(
        context: context,
        msg:
            '(Response 500) User Validtion failed: ${jsonDecode(response.body)['error']}',
      );
      break;
    default:
      MyDialogs.error(
        context: context,
        msg: 'Unknown error: ${response.body}}',
      );
      break;
  }
}
