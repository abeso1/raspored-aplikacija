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
}
