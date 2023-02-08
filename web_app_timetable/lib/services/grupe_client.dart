import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/grupa/grupa.dart';
import 'package:web_app_timetable/models/grupa/grupa_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class GrupeClient {
  Future<List<Grupa>> getGrupe(SkolaId skolaId) async {
    var response = await http.get(
      Uri.parse("$backendUrl/grupa/filter?skola_id=${skolaId.value}"),
    );

    List<Grupa> grupe = [];

    Map decoded = jsonDecode(response.body);

    List codedGrupe = decoded["data"];

    for (var element in codedGrupe) {
      grupe.add(
        Grupa(
          id: GrupaId(value: element['id']),
          naslov: element['naziv'],
          skolaId: SkolaId(value: element['skola_id']),
        ),
      );
    }

    return grupe;
  }

  Future<void> removeGrupa(int grupaId) async {
    await http.delete(
      Uri.parse("$backendUrl/grupa/$grupaId"),
    );
  }

  Future<void> addGrupa(String grupa, SkolaId skolaId) async {
    await http.post(
      Uri.parse("$backendUrl/grupa"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'naziv': grupa,
          'skola_id': skolaId.value,
        },
      ),
    );
  }
}
