import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  bool userLoggedIn = false;

  bool login(String mail, String password) {
    if (mail == 'admin@admin.com' && password == 'admin1234') {
      userLoggedIn = true;
    } else {
      userLoggedIn = false;
    }
    notifyListeners();
    return userLoggedIn;
  }
}
