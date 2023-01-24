import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/skola/skola.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class SkolaClient {
  Future<List<Skola>> getSkole() async {
    var response = await http.get(
      Uri.parse("$backendUrl/skola"),
    );

    List<Skola> skole = [];

    Map decoded = jsonDecode(response.body);

    List codedSkole = decoded["data"];

    for (var element in codedSkole) {
      skole.add(
        Skola(
          id: SkolaId(value: element['id']),
          adresa: element['adresa'],
          email: element['email'],
          lozinka: element['sifra'],
          naziv: element['naziv'],
        ),
      );
    }

    return skole;
  }

  Future<void> addSkolu(String naziv, String adresa, String login, String sifra,
      String email) async {
    await http.post(
      Uri.parse("$backendUrl/skola"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'naziv': naziv,
          'adresa': adresa,
          'login': login,
          'sifra': sifra,
          'email': email,
        },
      ),
    );
  }

  Future<void> removeSkola(int skolaId) async {
    await http.delete(
      Uri.parse("$backendUrl/skola/$skolaId"),
    );
  }
}
