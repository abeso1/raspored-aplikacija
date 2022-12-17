import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  bool userLoggedIn = false;
  UserType userType = UserType.none;

  Future<bool> login(String mail, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (mail == 'admin@admin.com' && password == 'admin1234') {
      userLoggedIn = true;
      userType = UserType.admin;
    } else if (mail == 'skola@admin.com' && password == 'skola1234') {
      userLoggedIn = true;
      userType = UserType.skola;
    } else {
      userLoggedIn = false;
    }
    notifyListeners();
    return userLoggedIn;
  }

  logout() {
    userLoggedIn = false;
    notifyListeners();
  }
}

enum UserType { none, admin, skola }
