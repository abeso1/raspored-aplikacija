import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';
import 'package:web_app_timetable/models/termin/dan.dart';
import 'package:web_app_timetable/models/termin/termin.dart';

import '../models/termin/termin_id.dart';
import '../services/termini_client.dart';

class TerminiNotifier extends ChangeNotifier {
  bool getTerminiError = false;
  bool getTerminiLoading = true;
  List<Termin> termini = [];
  List<Termin> unfilteredTermini = [];
  TimeOfDay? najraniji;
  TimeOfDay? najkasniji;
  List<String>? sati;
  late Map<Dan, List<Termin>> normalisedTermins;

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

  _setTermini(List<Termin> terminiLocal) {
    _getNajranijiINajkasniji(terminiLocal);
    _getNormalisedTermine(terminiLocal);
    termini = terminiLocal;
  }

  _getNajranijiINajkasniji(List<Termin> terminiLocal) {
    for (var termin in terminiLocal) {
      najraniji ??= termin.pocetak;
      najkasniji ??= termin.kraj;
      if (termin.pocetak.hour < najraniji!.hour) {
        najraniji = termin.pocetak;
      }
      if (termin.kraj.hour > najkasniji!.hour) {
        najkasniji = termin.kraj;
      }
    }

    if (najraniji != null && najkasniji != null) {
      sati = [];
      for (var i = najraniji!.hour; i <= najkasniji!.hour; i++) {
        sati!.add("$i:00");
      }
    }
  }

  _getNormalisedTermine(List<Termin> terminiLocal) {
    Map<Dan, List<Termin>> mappedTerminAccrossTheDays = {
      Dan.ponedjeljak: [],
      Dan.utorak: [],
      Dan.srijeda: [],
      Dan.cetvrtak: [],
      Dan.petak: [],
    };

    for (var termin in terminiLocal) {
      mappedTerminAccrossTheDays[termin.dan]!.add(termin);
    }

    List<Termin> unshowableTermini = [];

    mappedTerminAccrossTheDays.forEach((key, value) {
      value.sort((a, b) =>
          _timeOfDayToInt(a.pocetak).compareTo(_timeOfDayToInt(b.pocetak)));
    });

    mappedTerminAccrossTheDays.forEach((key, value) {
      for (var i = 0; i < value.length; i++) {
        if (i == 0 &&
            (najraniji!.hour != value[0].pocetak.hour ||
                najraniji!.minute != value[0].pocetak.minute)) {
          unshowableTermini.add(
            Termin(
                pocetak: najraniji!,
                kraj: value[0].pocetak,
                dan: key,
                id: TerminId(value: -1),
                skolaId: SkolaId(value: -1),
                smjena: -1,
                show: false),
          );
        } else {
          if (i != 0 &&
              ((value[i - 1]).kraj.hour != (value[i]).pocetak.hour ||
                  (value[i - 1]).kraj.minute != (value[i]).pocetak.minute)) {
            unshowableTermini.add(
              Termin(
                  pocetak: (value[i - 1]).kraj,
                  kraj: (value[i]).pocetak,
                  dan: key,
                  id: TerminId(value: -1),
                  skolaId: SkolaId(value: -1),
                  smjena: -1,
                  show: false),
            );
          }
        }
      }
    });

    for (var termin in unshowableTermini) {
      mappedTerminAccrossTheDays[termin.dan]!.add(termin);
    }

    mappedTerminAccrossTheDays.forEach((key, value) {
      value.sort((a, b) =>
          _timeOfDayToInt(a.pocetak).compareTo(_timeOfDayToInt(b.pocetak)));
    });

    normalisedTermins = mappedTerminAccrossTheDays;
  }

  int _timeOfDayToInt(TimeOfDay myTime) => myTime.hour * 60 + myTime.minute;

  List<Map<String, String>> getTimeslotList() {
    return unfilteredTermini.map((termin) => termin.toJson()).toList();
  }
}
