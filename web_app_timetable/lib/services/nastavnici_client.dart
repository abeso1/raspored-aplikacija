import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/nastavnik/nastavnik.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class NastavniciClient {
  Future<List<Nastavnik>> getNastavnici(SkolaId skolaId) async {
    var response = await http.get(
      Uri.parse("$backendUrl/nastavnik/filter?skola_id=${skolaId.value}"),
    );

    List<Nastavnik> nastavnici = [];

    Map decoded = jsonDecode(response.body);

    List codedNastavnici = decoded["data"];

    for (var element in codedNastavnici) {
      nastavnici.add(
        Nastavnik(
          id: NastavnikId(value: element['id']),
          naslov: element['naziv'],
          skolaId: SkolaId(value: element['skola_id']),
        ),
      );
    }

    return nastavnici;
  }

  Future<void> addNastavnik(String predmet, SkolaId skolaId) async {
    await http.post(
      Uri.parse("$backendUrl/nastavnik"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'naziv': predmet,
          'skola_id': skolaId.value,
        },
      ),
    );
  }

  Future<void> removeNastavnik(int nastavnikId) async {
    await http.delete(
      Uri.parse("$backendUrl/nastavnik/$nastavnikId"),
    );
  }
}
