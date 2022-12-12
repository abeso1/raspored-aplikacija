import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_app_timetable/models/grupa/grupa_id.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/models/plan/plan.dart';
import 'package:web_app_timetable/models/plan/plan_id.dart';
import 'package:web_app_timetable/models/predmet/predmet_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

import '../shared/global_variables.dart';

class NastavniPlanClient {
  Future<List<Plan>> getNastavniPlan() async {
    var response = await http.get(
      Uri.parse("$backendUrl/predavanje"),
    );

    List<Plan> nastavniPlan = [];

    Map decoded = jsonDecode(response.body);

    List codedNastavniPlan = decoded["data"];

    for (var element in codedNastavniPlan) {
      nastavniPlan.add(
        Plan(
            id: PlanId(value: element['id']),
            skolaId: SkolaId(value: element['skola_id']),
            grupaId: GrupaId(value: element['grupa_id']),
            nastavnikId: NastavnikId(value: element['nastavnik_id']),
            predmetId: PredmetId(value: element['predmet_id']),
            brojCasova: element['broj_casova']),
      );
    }

    return nastavniPlan;
  }

  Future<bool> addNastavniPlan(final PredmetId predmetId, final GrupaId grupaId,
      final NastavnikId nastavnikId, final int brojCasova) async {
    var response = await http.post(Uri.parse("$backendUrl/predavanje"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "predmet_id": predmetId.value,
          "nastavnik_id": nastavnikId.value,
          "grupa_id": grupaId.value,
          "broj_casova": brojCasova,
          "skola_id": 1
        }));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
