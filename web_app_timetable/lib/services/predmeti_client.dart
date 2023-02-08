import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/predmet/predmet.dart';
import 'package:web_app_timetable/models/predmet/predmet_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class PredmetiClient {
  Future<List<Predmet>> getPredmeti(SkolaId skolaId) async {
    var response = await http.get(
      Uri.parse("$backendUrl/predmet/filter?skola_id=${skolaId.value}"),
    );

    List<Predmet> predmeti = [];

    Map decoded = jsonDecode(response.body);

    List codedPredmeti = decoded["data"];

    for (var element in codedPredmeti) {
      predmeti.add(
        Predmet(
          id: PredmetId(value: element['id']),
          naslov: element['naslov'],
          skolaId: SkolaId(value: element['skola_id']),
        ),
      );
    }

    return predmeti;
  }

  Future<void> removePredmet(int predmetId) async {
    await http.delete(
      Uri.parse("$backendUrl/predmet/$predmetId"),
    );
  }

  Future<void> addPredmet(String predmet) async {
    await http.post(
      Uri.parse("$backendUrl/predmet"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {'naslov': predmet, 'skola_id': 1, 'css': ''},
      ),
    );
  }
}
