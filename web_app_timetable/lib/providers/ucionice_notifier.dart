import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/ucionica/ucionica.dart';
import 'package:web_app_timetable/models/ucionica/ucionica_id.dart';
import 'package:web_app_timetable/services/ucionice_client.dart';

Map ucioniceSort = {
  UcioniceSort.atoz: 'Sortiraj: A-Z',
  UcioniceSort.ztoa: 'Sortiraj: Z-A',
};

class UcioniceNotifier extends ChangeNotifier {
  bool getUcioniceError = false;
  bool getUcioniceLoading = true;
  bool ucioniceFiltered = false;
  List<Ucionica> ucionice = [];
  List<Ucionica> unfilteredUcionice = [];
  UcioniceSort ucioniceSort = UcioniceSort.atoz;
  String ucionicaFilter = '';

  getUcionice() async {
    try {
      unfilteredUcionice = await UcioniceClient().getUcionice();
      _setUcionice(unfilteredUcionice);
      getUcioniceLoading = false;
      getUcioniceError = false;
    } catch (e) {
      getUcioniceLoading = false;
      getUcioniceError = true;
    }
    notifyListeners();
  }

  filterUcionice(String filter) {
    ucionicaFilter = filter;
    ucioniceFiltered = filter.isNotEmpty && unfilteredUcionice.isNotEmpty;
    _setUcionice(unfilteredUcionice);
    notifyListeners();
  }

  setUcioniceSort(UcioniceSort sort) {
    ucioniceSort = sort;
    _setUcionice(unfilteredUcionice);
    notifyListeners();
  }

  _setUcionice(List<Ucionica> ucioniceLocal) {
    ucionice = ucioniceLocal
        .where((ucionica) =>
            ucionica.naslov
                .toLowerCase()
                .contains(ucionicaFilter.toLowerCase()) ||
            ucionicaFilter.isEmpty)
        .toList();
    ucionice.sort((a, b) {
      if (ucioniceSort == UcioniceSort.atoz) {
        return a.naslov.compareTo(b.naslov);
      }
      return b.naslov.compareTo(a.naslov);
    });
  }

  List<Map<String, String>> getRoomList() {
    return unfilteredUcionice.map((ucionica) => ucionica.toJson()).toList();
  }

  removeUcionica(UcionicaId ucionicaId) async {
    try {
      await UcioniceClient().removeUcionica(ucionicaId.value);
    } catch (e) {
      debugPrint(e.toString());
    }
    getUcionice();
  }

  String? ucionicaDialog;

  setUcionicaDialog(String? value, {bool notify = true}) {
    ucionicaDialog = value;
    if (notify) {
      notifyListeners();
    }
  }
}

enum UcioniceSort {
  atoz,
  ztoa,
}
