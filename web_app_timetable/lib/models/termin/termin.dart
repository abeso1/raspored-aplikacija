import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';
import 'package:web_app_timetable/models/termin/dan.dart';
import 'package:web_app_timetable/models/termin/termin_id.dart';

class Termin {
  final TerminId? id;
  final Dan dan;
  final TimeOfDay pocetak;
  final TimeOfDay kraj;
  final SkolaId? skolaId;
  final int? smjena;
  final bool? show;

  Termin({
    this.id,
    required this.dan,
    required this.kraj,
    required this.pocetak,
    this.skolaId,
    this.smjena,
    this.show = true,
  });

  Map<String, String> toJson() {
    return {
      'dayOfWeek': daniMappedNaEngleski[dan]!,
      'startTime': '${timeOfDayToString(pocetak)}:00',
      'endTime': '${timeOfDayToString(kraj)}:00',
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Termin &&
        other.dan == dan &&
        other.pocetak == pocetak &&
        other.kraj == kraj;
  }

  @override
  int get hashCode => dan.hashCode ^ pocetak.hashCode ^ kraj.hashCode;
}

Termin terminFromJson(Map json) {
  List<String> pocetak = (json['startTime'] as String).split(':');
  List<String> kraj = (json['endTime'] as String).split(':');
  return Termin(
    dan: daniMapped[json['dayOfWeek']]!,
    kraj: TimeOfDay(hour: int.parse(kraj[0]), minute: int.parse(kraj[1])),
    pocetak:
        TimeOfDay(hour: int.parse(pocetak[0]), minute: int.parse(pocetak[1])),
  );
}

String timeOfDayToString(TimeOfDay timeOfDay) {
  DateTime dateTime = DateTime(2022, 1, 1, timeOfDay.hour, timeOfDay.minute);
  return DateFormat('HH:mm').format(dateTime);
}
