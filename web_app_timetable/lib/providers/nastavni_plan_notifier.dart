import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/plan/plan_id.dart';
import '../models/plan/plan.dart';
import '../models/skola/skola_id.dart';
import '../services/nastavni_plan_client.dart';

class NastavniPlanNotifier extends ChangeNotifier {
  bool getNastavniPlanError = false;
  bool getNastavniPlanLoading = true;
  List<Plan> nastavniPlan = [];
  List<Plan> unfilteredNastavniPlan = [];

  SkolaId? skolaId;

  setSkolaId(SkolaId value) {
    skolaId = value;
  }

  getNastavniPlan() async {
    try {
      unfilteredNastavniPlan =
          await NastavniPlanClient().getNastavniPlan(skolaId!);
      _setNastavniPlan(unfilteredNastavniPlan);
      getNastavniPlanLoading = false;
      getNastavniPlanError = false;
    } catch (e) {
      getNastavniPlanLoading = false;
      getNastavniPlanError = true;
    }
    notifyListeners();
  }

  _setNastavniPlan(List<Plan> nastavniPlanLocal) {
    nastavniPlan = nastavniPlanLocal;
  }

  addPlan(Plan plan) {
    nastavniPlan.add(plan);
    unfilteredNastavniPlan.add(plan);
    notifyListeners();
  }

  List<Map<String, int>> getLessonList() {
    List<Map<String, int>> planovi = [];
    for (var plan in unfilteredNastavniPlan) {
      planovi.addAll(plan.toJsonList());
    }

    return planovi;
  }

  removeNastavniPlan(PlanId planId) async {
    try {
      await NastavniPlanClient().removeNastavniPlan(planId.value);
    } catch (e) {
      debugPrint(e.toString());
    }
    getNastavniPlan();
  }
}
