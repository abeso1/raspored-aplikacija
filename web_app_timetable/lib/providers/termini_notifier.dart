import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/termin/termin.dart';
import 'package:web_app_timetable/services/termini_client.dart';

Map terminiSort = {
  TerminiSort.atoz: 'Sortiraj: A-Z',
  TerminiSort.ztoa: 'Sortiraj: Z-A',
};

class TerminiNotifier extends ChangeNotifier {
  bool getTerminiError = false;
  bool getTerminiLoading = true;
  bool terminiFiltered = false;
  List<Termin> termini = [];
  List<Termin> unfilteredTermini = [];
  TerminiSort terminiSort = TerminiSort.atoz;
  String terminFilter = '';

  getTermini() async {
    try {
      unfilteredTermini = await TerminiClient().getTermini();
      _setTermini(unfilteredTermini);
      getTerminiLoading = false;
      getTerminiError = false;
    } catch (e) {
      getTerminiLoading = false;
      getTerminiError = true;
    }
    notifyListeners();
  }

  filterTermini(String filter) {
    terminFilter = filter;
    terminiFiltered = filter.isNotEmpty && unfilteredTermini.isNotEmpty;
    _setTermini(unfilteredTermini);
    notifyListeners();
  }

  setTerminiSort(TerminiSort sort) {
    terminiSort = sort;
    _setTermini(unfilteredTermini);
    notifyListeners();
  }

  _setTermini(List<Termin> terminiLocal) {
    termini = terminiLocal;
  }
}

enum TerminiSort {
  atoz,
  ztoa,
}
