import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/nastavnik/nastavnik.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class NastavniciClient {
  Future<List<Nastavnik>> getNastavnici() async {
    var response = await http.get(
      Uri.parse("$backendUrl/nastavnik"),
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
}
