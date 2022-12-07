import 'package:flutter/material.dart';

class TabNotifier extends ChangeNotifier {
  AppTab selectedTab = AppTab.raspored;

  Map<AppTab, String> tabNames = {
    AppTab.raspored: 'Raspored',
    AppTab.profesori: 'Profesori',
    AppTab.odjeljenja: 'Odjeljenja',
    AppTab.predmeti: 'Predmeti',
    AppTab.ucionice: 'Učionice',
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
}
