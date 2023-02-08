import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';
import 'package:web_app_timetable/services/login_client.dart';

class AuthNotifier extends ChangeNotifier {
  //bool userLoggedIn = false;
  //UserType userType = UserType.none;
  bool userLoggedIn = true;
  UserType userType = UserType.skola;
  SkolaId skolaId = SkolaId(value: 1);

  Future<bool> login(String mail, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    await LoginClient().login(mail, password);

    if (mail == 'admin@admin.com' && password == 'admin123') {
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
