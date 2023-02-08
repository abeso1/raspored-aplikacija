import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/grupa/grupa_id.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/models/predmet/predmet_id.dart';
import 'package:web_app_timetable/services/nastavni_plan_client.dart';

import '../models/skola/skola_id.dart';

class AddNastavniPlanNotifier extends ChangeNotifier {
  NastavnikId? nastavnikId;
  PredmetId? predmetId;
  GrupaId? grupaId;
  int? brojCasova;

  SkolaId? skolaId;

  setSkolaId(SkolaId value) {
    skolaId = value;
  }

  reset() {
    nastavnikId = null;
    predmetId = null;
    grupaId = null;
    brojCasova = null;
  }

  setNastavnikId(NastavnikId? nastavnikIdToSet) {
    nastavnikId = nastavnikIdToSet;
    notifyListeners();
  }

  setPredmetId(PredmetId? predmetIdToSet) {
    predmetId = predmetIdToSet;
    notifyListeners();
  }

  setGrupaId(GrupaId? grupaIdToSet) {
    grupaId = grupaIdToSet;
    notifyListeners();
  }

  setBrojCasova(int? brojCasovaToSet) {
    brojCasova = brojCasovaToSet;
    notifyListeners();
  }

  Future<bool> addNastavniPlan() async {
    try {
      return await NastavniPlanClient().addNastavniPlan(
          predmetId!, grupaId!, nastavnikId!, brojCasova!, skolaId!);
    } catch (e) {
      return false;
    }
  }
}
