import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/grupa/grupa.dart';
import 'package:web_app_timetable/services/grupe_client.dart';

import '../models/grupa/grupa_id.dart';

Map grupeSort = {
  GrupeSort.atoz: 'Sortiraj: A-Z',
  GrupeSort.ztoa: 'Sortiraj: Z-A',
};

class GrupeNotifier extends ChangeNotifier {
  bool getGrupeError = false;
  bool getGrupeLoading = true;
  bool grupeFiltered = false;
  List<Grupa> grupe = [];
  Map<GrupaId, Grupa> grupeMapped = {};
  List<Grupa> unfilteredGrupe = [];
  GrupeSort grupeSort = GrupeSort.atoz;
  String grupaFilter = '';

  getGrupe() async {
    try {
      unfilteredGrupe = await GrupeClient().getGrupe();
      _setGrupe(unfilteredGrupe);
      getGrupeLoading = false;
      getGrupeError = false;
    } catch (e) {
      getGrupeLoading = false;
      getGrupeError = true;
    }
    notifyListeners();
  }

  filterGrupe(String filter) {
    grupaFilter = filter;
    grupeFiltered = filter.isNotEmpty && unfilteredGrupe.isNotEmpty;
    _setGrupe(unfilteredGrupe);
    notifyListeners();
  }

  setGrupeSort(GrupeSort sort) {
    grupeSort = sort;
    _setGrupe(unfilteredGrupe);
    notifyListeners();
  }

  _setGrupe(List<Grupa> grupeLocal) {
    grupe = grupeLocal
        .where((grupa) =>
            grupa.naslov.toLowerCase().contains(grupaFilter.toLowerCase()) ||
            grupaFilter.isEmpty)
        .toList();
    for (var grupa in grupeLocal) {
      grupeMapped[grupa.id] = grupa;
    }
    grupe.sort((a, b) {
      if (grupeSort == GrupeSort.atoz) {
        return a.naslov.compareTo(b.naslov);
      }
      return b.naslov.compareTo(a.naslov);
    });
  }

  removeGrupe(GrupaId grupaId) async {
    try {
      await GrupeClient().removeGrupa(grupaId.value);
    } catch (e) {
      debugPrint(e.toString());
    }
    getGrupe();
  }

  String? odjeljenjeDialog;

  setOdjeljenjeDialog(String? value) {
    odjeljenjeDialog = value;
    notifyListeners();
  }
}

enum GrupeSort {
  atoz,
  ztoa,
}
