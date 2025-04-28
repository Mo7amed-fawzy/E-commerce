import 'package:e_commerce_app/app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User.getNewEmptyUser();

  User get user => _user;

  void setUserFromModel(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
