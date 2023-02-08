import 'dart:convert';

import 'package:http/http.dart' as http;

import '../shared/global_variables.dart';

class LoginClient {
  Future<dynamic> login(String email, String password) async {
    var response = await http.post(
      Uri.parse("$backendUrl/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'email': email,
          'sifra': password,
        },
      ),
    );
  }
}
