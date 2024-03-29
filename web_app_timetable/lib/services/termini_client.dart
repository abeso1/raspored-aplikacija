import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/termin/dan.dart';
import 'package:web_app_timetable/models/termin/termin.dart';
import 'package:web_app_timetable/models/termin/termin_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class TerminiClient {
  Future<List<Termin>> getTermini(SkolaId skolaId) async {
    var response = await http.get(
      Uri.parse("$backendUrl/termin/filter?skola_id=${skolaId.value}"),
    );

    List<Termin> termini = [];

    Map decoded = jsonDecode(response.body);

    List codedTermini = decoded["data"];

    for (var element in codedTermini) {
      List<String> pocetak = (element['pocetak'] as String).split(':');
      List<String> kraj = (element['kraj'] as String).split(':');

      termini.add(
        Termin(
          id: TerminId(value: element['id']),
          dan: daniMapped[element['dan']]!,
          skolaId: SkolaId(value: element['skola_id']),
          kraj: TimeOfDay(hour: int.parse(kraj[0]), minute: int.parse(kraj[1])),
          pocetak: TimeOfDay(
              hour: int.parse(pocetak[0]), minute: int.parse(pocetak[1])),
          smjena: element['smjena'],
        ),
      );
    }

    return termini;
  }

  Future<void> removeTermin(int terminId) async {
    await http.delete(
      Uri.parse("$backendUrl/termin/$terminId"),
    );
  }

  Future<void> addTermin(
      TimeOfDay start, TimeOfDay end, Dan day, SkolaId skolaId) async {
    await http.post(
      Uri.parse("$backendUrl/termin"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          'dan': daniMappedNaEngleski[day],
          'pocetak':
              "${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}:00",
          'kraj':
              "${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}:00",
          'skola_id': skolaId.value,
          'smjena': 1,
        },
      ),
    );
  }
}
