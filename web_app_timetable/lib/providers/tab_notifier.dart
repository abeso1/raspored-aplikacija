import 'package:flutter/material.dart';

class TabNotifier extends ChangeNotifier {
  AppTab selectedTab = AppTab.nastavniplan;

  Map<AppTab, String> tabNames = {
    AppTab.raspored: 'Raspored',
    AppTab.profesori: 'Profesori',
    AppTab.odjeljenja: 'Odjeljenja',
    AppTab.predmeti: 'Predmeti',
    AppTab.ucionice: 'Učionice',
    AppTab.termini: 'Termini',
    AppTab.nastavniplan: 'Nastavni plan',
  };

  setSelectedTab(AppTab tab) {
    selectedTab = tab;
    notifyListeners();
  }
}

enum AppTab {
  raspored,
  profesori,
  odjeljenja,
  predmeti,
  ucionice,
  termini,
  nastavniplan
}
