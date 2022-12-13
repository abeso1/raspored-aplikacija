import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/predmet/predmet.dart';
import 'package:web_app_timetable/services/predmeti_client.dart';

import '../models/predmet/predmet_id.dart';

Map predmetiSort = {
  PredmetiSort.atoz: 'Sortiraj: A-Z',
  PredmetiSort.ztoa: 'Sortiraj: Z-A',
};

class PredmetiNotifier extends ChangeNotifier {
  bool getPredmetiError = false;
  bool getPredmetiLoading = true;
  bool predmetiFiltered = false;
  List<Predmet> predmeti = [];
  Map<PredmetId, Predmet> predmetiMapped = {};
  List<Predmet> unfilteredPredmeti = [];
  PredmetiSort predmetiSort = PredmetiSort.atoz;
  String predmetFilter = '';

  getPredmeti() async {
    try {
      unfilteredPredmeti = await PredmetiClient().getPredmeti();
      _setPredmeti(unfilteredPredmeti);
      getPredmetiLoading = false;
      getPredmetiError = false;
    } catch (e) {
      getPredmetiLoading = false;
      getPredmetiError = true;
    }
    notifyListeners();
  }

  filterPredmeti(String filter) {
    predmetFilter = filter;
    predmetiFiltered = filter.isNotEmpty && unfilteredPredmeti.isNotEmpty;
    _setPredmeti(unfilteredPredmeti);
    notifyListeners();
  }

  setPredmetiSort(PredmetiSort sort) {
    predmetiSort = sort;
    _setPredmeti(unfilteredPredmeti);
    notifyListeners();
  }

  _setPredmeti(List<Predmet> predmetiLocal) {
    predmeti = predmetiLocal
        .where((predmet) =>
            predmet.naslov
                .toLowerCase()
                .contains(predmetFilter.toLowerCase()) ||
            predmetFilter.isEmpty)
        .toList();
    for (var predmet in predmetiLocal) {
      predmetiMapped[predmet.id] = predmet;
    }
    predmeti.sort((a, b) {
      if (predmetiSort == PredmetiSort.atoz) {
        return a.naslov.compareTo(b.naslov);
      }
      return b.naslov.compareTo(a.naslov);
    });
  }

  removePredmet(PredmetId predmetId) async {
    try {
      await PredmetiClient().removePredmet(predmetId.value);
    } catch (e) {
      debugPrint(e.toString());
    }
    getPredmeti();
  }
}

enum PredmetiSort {
  atoz,
  ztoa,
}
