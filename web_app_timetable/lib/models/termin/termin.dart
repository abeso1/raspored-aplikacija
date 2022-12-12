import 'package:flutter/material.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';
import 'package:web_app_timetable/models/termin/dan.dart';
import 'package:web_app_timetable/models/termin/termin_id.dart';

class Termin {
  final TerminId id;
  final Dan dan;
  final TimeOfDay pocetak;
  final TimeOfDay kraj;
  final SkolaId skolaId;
  final int smjena;
  final bool show;

  Termin({
    required this.id,
    required this.dan,
    required this.kraj,
    required this.pocetak,
    required this.skolaId,
    required this.smjena,
    this.show = true,
  });

  Map<String, String> toJson() {
    return {
      'dayOfWeek': daniMappedNaEngleski[dan]!,
      'startTime': '${timeOfDayToString(pocetak)}:00',
      'endTime': '${timeOfDayToString(kraj)}:00',
    };
  }
}

String timeOfDayToString(TimeOfDay timeOfDay) {
  return timeOfDay.toString().replaceAll('TimeOfDay(', '').replaceAll(')', '');
}
