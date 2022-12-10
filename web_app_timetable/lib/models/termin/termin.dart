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

  Termin({
    required this.id,
    required this.dan,
    required this.kraj,
    required this.pocetak,
    required this.skolaId,
    required this.smjena,
  });
}
