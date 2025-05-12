import 'package:e_commerce_app/core/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // User related properties and methods
  User _user = User.getNewEmptyUser();
  User get user => _user;

  void setUserFromModel(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setObjectUser(User user) {
    _user = user;
    notifyListeners();
  }

  // MyAppProvider related properties and methods
  bool isAccepted = false;
  ThemeMode theme = ThemeMode.system;
  String language = 'en'; // Default language (English)

  Color primaryColor = Colors.blue; // Default primary color

  void toggleAcceptance() {
    isAccepted = !isAccepted;
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    if (newLanguage == language) {
      return;
    }
    language = newLanguage == 'en' ? 'en' : 'ar';
    notifyListeners();
  }
}
