import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/ucionica/ucionica.dart';
import 'package:web_app_timetable/models/ucionica/ucionica_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class UcioniceClient {
  Future<List<Ucionica>> getUcionice() async {
    var response = await http.get(
      Uri.parse("$backendUrl/ucionica"),
    );

    List<Ucionica> ucionice = [];

    Map decoded = jsonDecode(response.body);

    List codedUcionice = decoded["data"];

    for (var element in codedUcionice) {
      ucionice.add(
        Ucionica(
          id: UcionicaId(value: element['id']),
          naslov: element['naziv'],
          skolaId: SkolaId(value: element['skola_id']),
        ),
      );
    }

    return ucionice;
  }

  Future<void> removeUcionica(int ucionicaId) async {
    await http.delete(
      Uri.parse("$backendUrl/ucionica/$ucionicaId"),
    );
  }

  Future<void> addUcionica(String ucionica) async {
    await http.post(
      Uri.parse("$backendUrl/ucionica"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'naziv': ucionica,
          'skola_id': 1,
        },
      ),
    );
  }
}
