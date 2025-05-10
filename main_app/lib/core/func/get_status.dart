import 'package:flutter/material.dart';

String getStatus(int value) {
  switch (value) {
    case 0:
      return "preparing";
    case 1:
      return "Preparing";
    case 2:
      return "Ready";
    case 3:
      return "On Way";
    case 4:
      return "Completed";
    default:
      return "preparing";
  }
}

Color? getStatusColor(int value) {
  switch (value) {
    case 0:
      return Colors.green;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.yellowAccent;
    case 3:
      return Colors.deepOrange;
    case 4:
      return Colors.red;
    default:
      return Colors.green;
  }
}
