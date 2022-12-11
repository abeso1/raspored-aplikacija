import 'package:flutter/material.dart';
import '../models/plan/plan.dart';
import '../services/nastavni_plan_client.dart';

class NastavniPlanNotifier extends ChangeNotifier {
  bool getNastavniPlanError = false;
  bool getNastavniPlanLoading = true;
  List<Plan> nastavniPlan = [];
  List<Plan> unfilteredNastavniPlan = [];

  getNastavniPlan() async {
    try {
      unfilteredNastavniPlan = await NastavniPlanClient().getNastavniPlan();
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
}
