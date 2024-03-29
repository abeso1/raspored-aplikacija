import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/services/nastavnici_client.dart';

import '../models/skola/skola_id.dart';

Map nastavniciSort = {
  NastavniciSort.atoz: 'Sortiraj: A-Z',
  NastavniciSort.ztoa: 'Sortiraj: Z-A',
};

class NastavniciNotifier extends ChangeNotifier {
  bool getNastavniciError = false;
  bool getNastavniciLoading = true;
  bool nastavniciFiltered = false;
  List<Nastavnik> nastavnici = [];
  Map<NastavnikId, Nastavnik> nastavniciMapped = {};
  List<Nastavnik> unfilteredNastavnici = [];
  NastavniciSort nastavniciSort = NastavniciSort.atoz;
  String nastavnikFilter = '';

  SkolaId? skolaId;

  setSkolaId(SkolaId value) {
    skolaId = value;
  }

  getNastavnici() async {
    try {
      unfilteredNastavnici = await NastavniciClient().getNastavnici(skolaId!);
      _setNastavnici(unfilteredNastavnici);
      getNastavniciLoading = false;
      getNastavniciError = false;
    } catch (e) {
      getNastavniciLoading = false;
      getNastavniciError = true;
    }
    notifyListeners();
  }

  filterNastavnici(String filter) {
    nastavnikFilter = filter;
    nastavniciFiltered = filter.isNotEmpty && unfilteredNastavnici.isNotEmpty;
    _setNastavnici(unfilteredNastavnici);
    notifyListeners();
  }

  setNastavniciSort(NastavniciSort sort) {
    nastavniciSort = sort;
    _setNastavnici(unfilteredNastavnici);
    notifyListeners();
  }

  _setNastavnici(List<Nastavnik> nastavniciLocal) {
    nastavnici = nastavniciLocal
        .where((nastavnik) =>
            nastavnik.naslov
                .toLowerCase()
                .contains(nastavnikFilter.toLowerCase()) ||
            nastavnikFilter.isEmpty)
        .toList();
    for (var nastavnik in nastavniciLocal) {
      nastavniciMapped[nastavnik.id] = nastavnik;
    }
    nastavnici.sort((a, b) {
      if (nastavniciSort == NastavniciSort.atoz) {
        return a.naslov.compareTo(b.naslov);
      }
      return b.naslov.compareTo(a.naslov);
    });
  }

  removeNastavnik(NastavnikId nastavnikId) async {
    try {
      await NastavniciClient().removeNastavnik(nastavnikId.value);
    } catch (e) {
      debugPrint(e.toString());
    }
    getNastavnici();
  }

  String? nastavnikDialog;

  setNastavnikDialog(String? value, {bool notify = true}) {
    nastavnikDialog = value;
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> addPredmet() async {
    try {
      await NastavniciClient().addNastavnik(nastavnikDialog!, skolaId!);
    } catch (e) {
      debugPrint(e.toString());
    }
    getNastavnici();
  }
}

enum NastavniciSort {
  atoz,
  ztoa,
}
