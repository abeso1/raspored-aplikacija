import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';
import 'package:web_app_timetable/services/login_client.dart';

class AuthNotifier extends ChangeNotifier {
  bool userLoggedIn = false;
  UserType userType = UserType.none;
  SkolaId? skolaId;

  Future<bool> login(String mail, String password) async {
    String response = await LoginClient().login(mail, password);

    Map decodedResponse = jsonDecode(response);

    if (decodedResponse["res"] == true) {
      userLoggedIn = true;
      userType = UserType.admin;
    } else if (decodedResponse["res"] != false) {
      userLoggedIn = true;
      userType = UserType.skola;
      skolaId = SkolaId(value: decodedResponse["res"][0]["id"]);
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
