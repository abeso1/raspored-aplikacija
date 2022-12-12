import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/grupa/grupa_id.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/models/raspored/raspored_id.dart';
import 'package:web_app_timetable/models/termin/termin.dart';
import 'package:web_app_timetable/models/ucionica/ucionica.dart';
import 'package:web_app_timetable/services/raspored_client.dart';
import '../models/predmet/predmet_id.dart';
import '../models/raspored/raspored.dart';
import '../models/raspored/raspored_settings.dart';
import '../models/skola/skola_id.dart';
import '../models/termin/dan.dart';
import '../models/termin/termin_id.dart';
import 'termini_notifier.dart';
import 'nastavni_plan_notifier.dart';
import 'ucionice_notifier.dart';

class RasporedNotifier extends ChangeNotifier {
  final TerminiNotifier terminiNotifier;
  final UcioniceNotifier ucioniceNotifier;
  final NastavniPlanNotifier nastavniPlanNotifier;

  RasporedNotifier({
    required this.terminiNotifier,
    required this.ucioniceNotifier,
    required this.nastavniPlanNotifier,
  });

  List<Termin> termini = [];
  List<Ucionica> ucionice = [];
  Set<Raspored> raspored = {};
  bool getRasporedError = false;

  List<GrupaId> grupe = [];
  List<NastavnikId> nastavnici = [];

  Map<GrupaId, Map<Dan, List<Raspored>>> mappedByGrupe = {};
  Map<Ucionica, Map<Dan, List<Raspored>>> mappedByUcionica = {};
  Map<NastavnikId, Map<Dan, List<Raspored>>> mappedByNastavnici = {};

  Map<GrupaId, RasporedSettings> rasporedSettingsPerGrupe = {};
  Map<NastavnikId, RasporedSettings> rasporedSettingsPerNastavnik = {};
  Map<Ucionica, RasporedSettings> rasporedSettingsPerUcionica = {};

  Future<void> createRaspored() async {
    getRasporedError = false;
    List<Map<String, String>> timeslotList = terminiNotifier.getTimeslotList();
    List<Map<String, String>> roomList = ucioniceNotifier.getRoomList();
    List<Map<String, int>> lessonList = nastavniPlanNotifier.getLessonList();

    String? response = await RasporedClient().createRaspored(
      roomList: roomList,
      timeslotList: timeslotList,
      lessonList: lessonList,
    );

    if (response == null) {
      getRasporedError = true;
      notifyListeners();
      return;
    }

    Map decoded = jsonDecode(response);

    print(decoded['timeslotList']);

    List decodedTermini = decoded['timeslotList'];
    termini = [];
    for (var termin in decodedTermini) {
      termini.add(terminFromJson(termin));
    }

    List decodedUcionice = decoded['roomList'];
    ucionice = [];
    for (var ucionica in decodedUcionice) {
      ucionice.add(ucionicaFromJson(ucionica));
    }

    List decodedRaspored = decoded['lessonList'];
    raspored = {};
    for (var element in decodedRaspored) {
      raspored.add(
        Raspored(
          id: RasporedId(value: element['id']),
          predmetId: PredmetId(value: int.parse(element['subject'])),
          nastavnikId: NastavnikId(value: int.parse(element['teacher'])),
          grupaId: GrupaId(value: int.parse(element['studentGroup'])),
          termin: terminFromJson(element['timeslot']),
          ucionica: ucionicaFromJson(element['room']),
        ),
      );
    }

    Set<GrupaId> grupeSet = {};
    Set<NastavnikId> nastavniciSet = {};

    for (var ras in raspored) {
      grupeSet.add(ras.grupaId);
      nastavniciSet.add(ras.nastavnikId);
      mappedByGrupe[ras.grupaId] ??= {
        Dan.ponedjeljak: [],
        Dan.utorak: [],
        Dan.srijeda: [],
        Dan.cetvrtak: [],
        Dan.petak: [],
      };

      mappedByNastavnici[ras.nastavnikId] ??= {
        Dan.ponedjeljak: [],
        Dan.utorak: [],
        Dan.srijeda: [],
        Dan.cetvrtak: [],
        Dan.petak: [],
      };
    }

    for (var ucionica in ucionice) {
      mappedByUcionica[ucionica] ??= {
        Dan.ponedjeljak: [],
        Dan.utorak: [],
        Dan.srijeda: [],
        Dan.cetvrtak: [],
        Dan.petak: [],
      };
    }

    for (var ras in raspored) {
      mappedByGrupe[ras.grupaId]![ras.termin.dan]!.add(ras);
      mappedByUcionica[ras.ucionica]![ras.termin.dan]!.add(ras);
      mappedByNastavnici[ras.nastavnikId]![ras.termin.dan]!.add(ras);
    }

    grupe = grupeSet.toList();
    nastavnici = nastavniciSet.toList();

    mappedByGrupe.forEach((grupaId, rasporedPoDanu) {
      rasporedPoDanu.forEach((dan, raspored) {
        raspored.sort((a, b) => _timeOfDayToInt(a.termin.pocetak)
            .compareTo(_timeOfDayToInt(b.termin.pocetak)));
      });
    });

    mappedByUcionica.forEach((ucionica, rasporedPoDanu) {
      rasporedPoDanu.forEach((dan, raspored) {
        raspored.sort((a, b) => _timeOfDayToInt(a.termin.pocetak)
            .compareTo(_timeOfDayToInt(b.termin.pocetak)));
      });
    });

    mappedByNastavnici.forEach((nastavnikId, rasporedPoDanu) {
      rasporedPoDanu.forEach((dan, raspored) {
        raspored.sort((a, b) => _timeOfDayToInt(a.termin.pocetak)
            .compareTo(_timeOfDayToInt(b.termin.pocetak)));
      });
    });

    mappedByGrupe.forEach((grupaId, rasporedPoDanu) {
      TimeOfDay? najraniji;
      TimeOfDay? najkasniji;
      rasporedPoDanu.forEach((dan, raspored) {
        if (raspored.isNotEmpty) {
          if (najraniji == null) {
            najraniji ??= raspored.first.termin.pocetak;
            najkasniji ??= raspored.last.termin.kraj;
          }
          if (raspored.first.termin.pocetak.hour < najraniji!.hour) {
            najraniji = raspored.first.termin.pocetak;
          }
          if (raspored.last.termin.kraj.hour > najkasniji!.hour) {
            najkasniji = raspored.last.termin.kraj;
          }
        }
      });

      rasporedSettingsPerGrupe[grupaId] =
          RasporedSettings(najraniji: najraniji, najkasniji: najkasniji);
    });

    mappedByNastavnici.forEach((nastavnikId, rasporedPoDanu) {
      TimeOfDay? najraniji;
      TimeOfDay? najkasniji;
      rasporedPoDanu.forEach((dan, raspored) {
        if (raspored.isNotEmpty) {
          if (najraniji == null) {
            najraniji ??= raspored.first.termin.pocetak;
            najkasniji ??= raspored.last.termin.kraj;
          }
          if (raspored.first.termin.pocetak.hour < najraniji!.hour) {
            najraniji = raspored.first.termin.pocetak;
          }
          if (raspored.last.termin.kraj.hour > najkasniji!.hour) {
            najkasniji = raspored.last.termin.kraj;
          }
        }
      });

      rasporedSettingsPerNastavnik[nastavnikId] =
          RasporedSettings(najraniji: najraniji, najkasniji: najkasniji);
    });

    mappedByUcionica.forEach((ucionica, rasporedPoDanu) {
      TimeOfDay? najraniji;
      TimeOfDay? najkasniji;
      rasporedPoDanu.forEach((dan, raspored) {
        if (raspored.isNotEmpty) {
          if (najraniji == null) {
            najraniji ??= raspored.first.termin.pocetak;
            najkasniji ??= raspored.last.termin.kraj;
          }
          if (raspored.first.termin.pocetak.hour < najraniji!.hour) {
            najraniji = raspored.first.termin.pocetak;
          }
          if (raspored.last.termin.kraj.hour > najkasniji!.hour) {
            najkasniji = raspored.last.termin.kraj;
          }
        }
      });

      rasporedSettingsPerUcionica[ucionica] =
          RasporedSettings(najraniji: najraniji, najkasniji: najkasniji);
    });

    Map<Ucionica, Map<Dan, List<Raspored>>> mappedByUcionicaCopy =
        Map.from(mappedByUcionica);

    mappedByUcionicaCopy.forEach((ucionica, rasporedPoDanu) {
      Map<Dan, List<Raspored>> unshowableRaspored = {
        Dan.ponedjeljak: [],
        Dan.utorak: [],
        Dan.srijeda: [],
        Dan.cetvrtak: [],
        Dan.petak: [],
      };
      rasporedPoDanu.forEach((dan, raspored) {
        for (var i = 0; i < raspored.length; i++) {
          if (i == 0 &&
              (rasporedSettingsPerUcionica[ucionica]!.najraniji!.hour !=
                      raspored.first.termin.pocetak.hour ||
                  rasporedSettingsPerUcionica[ucionica]!.najraniji!.minute !=
                      raspored.first.termin.pocetak.minute)) {
            unshowableRaspored[dan]!.add(
              Raspored(
                  id: RasporedId(value: -1),
                  predmetId: PredmetId(value: -1),
                  nastavnikId: NastavnikId(value: -1),
                  grupaId: GrupaId(value: -1),
                  termin: Termin(
                      pocetak:
                          rasporedSettingsPerUcionica[ucionica]!.najraniji!,
                      kraj: raspored.first.termin.pocetak,
                      dan: dan,
                      id: TerminId(value: -1),
                      skolaId: SkolaId(value: -1),
                      smjena: -1,
                      show: false),
                  ucionica: Ucionica(naslov: '')),
            );
          } else {
            if (i != 0 &&
                ((raspored[i - 1]).termin.kraj.hour !=
                        (raspored[i]).termin.pocetak.hour ||
                    (raspored[i - 1]).termin.kraj.minute !=
                        (raspored[i]).termin.pocetak.minute)) {
              unshowableRaspored[dan]!.add(
                Raspored(
                    id: RasporedId(value: -1),
                    predmetId: PredmetId(value: -1),
                    nastavnikId: NastavnikId(value: -1),
                    grupaId: GrupaId(value: -1),
                    termin: Termin(
                        pocetak: (raspored[i - 1]).termin.kraj,
                        kraj: (raspored[i]).termin.pocetak,
                        dan: dan,
                        id: TerminId(value: -1),
                        skolaId: SkolaId(value: -1),
                        smjena: -1,
                        show: false),
                    ucionica: Ucionica(naslov: '')),
              );
            }
          }
        }
      });

      mappedByUcionica[ucionica]!.forEach((dan, raspored) {
        raspored.addAll(unshowableRaspored[dan]!);
      });
    });

    Map<GrupaId, Map<Dan, List<Raspored>>> mappedByGrupeCopy =
        Map.from(mappedByGrupe);

    mappedByGrupeCopy.forEach((grupaId, rasporedPoDanu) {
      Map<Dan, List<Raspored>> unshowableRaspored = {
        Dan.ponedjeljak: [],
        Dan.utorak: [],
        Dan.srijeda: [],
        Dan.cetvrtak: [],
        Dan.petak: [],
      };
      rasporedPoDanu.forEach((dan, raspored) {
        for (var i = 0; i < raspored.length; i++) {
          if (i == 0 &&
              (rasporedSettingsPerGrupe[grupaId]!.najraniji!.hour !=
                      raspored.first.termin.pocetak.hour ||
                  rasporedSettingsPerGrupe[grupaId]!.najraniji!.minute !=
                      raspored.first.termin.pocetak.minute)) {
            unshowableRaspored[dan]!.add(
              Raspored(
                  id: RasporedId(value: -1),
                  predmetId: PredmetId(value: -1),
                  nastavnikId: NastavnikId(value: -1),
                  grupaId: GrupaId(value: -1),
                  termin: Termin(
                      pocetak: rasporedSettingsPerGrupe[grupaId]!.najraniji!,
                      kraj: raspored.first.termin.pocetak,
                      dan: dan,
                      id: TerminId(value: -1),
                      skolaId: SkolaId(value: -1),
                      smjena: -1,
                      show: false),
                  ucionica: Ucionica(naslov: '')),
            );
          } else {
            if (i != 0 &&
                ((raspored[i - 1]).termin.kraj.hour !=
                        (raspored[i]).termin.pocetak.hour ||
                    (raspored[i - 1]).termin.kraj.minute !=
                        (raspored[i]).termin.pocetak.minute)) {
              unshowableRaspored[dan]!.add(
                Raspored(
                    id: RasporedId(value: -1),
                    predmetId: PredmetId(value: -1),
                    nastavnikId: NastavnikId(value: -1),
                    grupaId: GrupaId(value: -1),
                    termin: Termin(
                        pocetak: (raspored[i - 1]).termin.kraj,
                        kraj: (raspored[i]).termin.pocetak,
                        dan: dan,
                        id: TerminId(value: -1),
                        skolaId: SkolaId(value: -1),
                        smjena: -1,
                        show: false),
                    ucionica: Ucionica(naslov: '')),
              );
            }
          }
        }
      });

      mappedByGrupe[grupaId]!.forEach((dan, raspored) {
        raspored.addAll(unshowableRaspored[dan]!);
      });
    });

    Map<NastavnikId, Map<Dan, List<Raspored>>> mappedByNastavniciCopy =
        Map.from(mappedByNastavnici);

    mappedByNastavniciCopy.forEach((nastavnikId, rasporedPoDanu) {
      Map<Dan, List<Raspored>> unshowableRaspored = {
        Dan.ponedjeljak: [],
        Dan.utorak: [],
        Dan.srijeda: [],
        Dan.cetvrtak: [],
        Dan.petak: [],
      };
      rasporedPoDanu.forEach((dan, raspored) {
        for (var i = 0; i < raspored.length; i++) {
          if (i == 0 &&
              (rasporedSettingsPerNastavnik[nastavnikId]!.najraniji!.hour !=
                      raspored.first.termin.pocetak.hour ||
                  rasporedSettingsPerNastavnik[nastavnikId]!
                          .najraniji!
                          .minute !=
                      raspored.first.termin.pocetak.minute)) {
            unshowableRaspored[dan]!.add(
              Raspored(
                  id: RasporedId(value: -1),
                  predmetId: PredmetId(value: -1),
                  nastavnikId: NastavnikId(value: -1),
                  grupaId: GrupaId(value: -1),
                  termin: Termin(
                      pocetak:
                          rasporedSettingsPerNastavnik[nastavnikId]!.najraniji!,
                      kraj: raspored.first.termin.pocetak,
                      dan: dan,
                      id: TerminId(value: -1),
                      skolaId: SkolaId(value: -1),
                      smjena: -1,
                      show: false),
                  ucionica: Ucionica(naslov: '')),
            );
          } else {
            if (i != 0 &&
                ((raspored[i - 1]).termin.kraj.hour !=
                        (raspored[i]).termin.pocetak.hour ||
                    (raspored[i - 1]).termin.kraj.minute !=
                        (raspored[i]).termin.pocetak.minute)) {
              unshowableRaspored[dan]!.add(
                Raspored(
                    id: RasporedId(value: -1),
                    predmetId: PredmetId(value: -1),
                    nastavnikId: NastavnikId(value: -1),
                    grupaId: GrupaId(value: -1),
                    termin: Termin(
                        pocetak: (raspored[i - 1]).termin.kraj,
                        kraj: (raspored[i]).termin.pocetak,
                        dan: dan,
                        id: TerminId(value: -1),
                        skolaId: SkolaId(value: -1),
                        smjena: -1,
                        show: false),
                    ucionica: Ucionica(naslov: '')),
              );
            }
          }
        }
      });

      mappedByNastavnici[nastavnikId]!.forEach((dan, raspored) {
        raspored.addAll(unshowableRaspored[dan]!);
      });
    });

    mappedByGrupe.forEach((grupaId, rasporedPoDanu) {
      rasporedPoDanu.forEach((dan, raspored) {
        raspored.sort((a, b) => _timeOfDayToInt(a.termin.pocetak)
            .compareTo(_timeOfDayToInt(b.termin.pocetak)));
      });
    });

    mappedByUcionica.forEach((ucionica, rasporedPoDanu) {
      rasporedPoDanu.forEach((dan, raspored) {
        raspored.sort((a, b) => _timeOfDayToInt(a.termin.pocetak)
            .compareTo(_timeOfDayToInt(b.termin.pocetak)));
      });
    });

    mappedByNastavnici.forEach((nastavnikId, rasporedPoDanu) {
      rasporedPoDanu.forEach((dan, raspored) {
        raspored.sort((a, b) => _timeOfDayToInt(a.termin.pocetak)
            .compareTo(_timeOfDayToInt(b.termin.pocetak)));
      });
    });
    notifyListeners();
  }

  int _timeOfDayToInt(TimeOfDay myTime) => myTime.hour * 60 + myTime.minute;

  RasporedType rasporedType = RasporedType.grupa;

  setRasporedType(RasporedType value) {
    rasporedType = value;
    notifyListeners();
  }

  GrupaId? selectedGrupa;

  setSelectedGrupa(GrupaId? value) {
    selectedGrupa = value;
    notifyListeners();
  }

  Ucionica? selectedUcionica;

  setSelectedUcionica(Ucionica? value) {
    selectedUcionica = value;
    notifyListeners();
  }

  NastavnikId? selectedNastavnik;

  setSelectedNastavnik(NastavnikId? value) {
    selectedNastavnik = value;
    notifyListeners();
  }
}

enum RasporedType {
  grupa,
  ucionica,
  nastavnik,
}

Map<RasporedType, String> rasporedTypeMappedToBosanski = {
  RasporedType.grupa: 'Po odjeljenjima',
  RasporedType.ucionica: 'Po učionicama',
  RasporedType.nastavnik: 'Po nastavnicima',
};
