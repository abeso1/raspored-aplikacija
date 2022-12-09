import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/grupa/grupa.dart';
import 'package:web_app_timetable/models/grupa/grupa_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class GrupeClient {
  Future<List<Grupa>> getGrupe() async {
    var response = await http.get(
      Uri.parse("$backendUrl/grupa"),
    );

    List<Grupa> grupe = [];

    Map decoded = jsonDecode(response.body);

    List codedGrupe = decoded["data"];

    for (var element in codedGrupe) {
      grupe.add(Grupa(
          id: GrupaId(value: element['id']),
          naslov: element['naziv'],
          skolaId: SkolaId(value: element['skola_id'])));
    }

    http.get(
      Uri.parse("$backendUrl/predavanje"),
    );

    return grupe;
  }
}
