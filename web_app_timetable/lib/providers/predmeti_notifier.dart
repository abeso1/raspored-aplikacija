import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/predmet/predmet.dart';
import 'package:web_app_timetable/services/predmeti_client.dart';

class PredmetiNotifier extends ChangeNotifier {
  bool getPredmetiError = false;
  bool getPredmetiLoading = true;
  List<Predmet> predmeti = [];

  getPredmeti() async {
    try {
      predmeti = await PredmetiClient().getPredmeti();
      getPredmetiLoading = false;
      getPredmetiError = false;
    } catch (e) {
      getPredmetiLoading = false;
      getPredmetiError = true;
    }
    notifyListeners();
  }
}
