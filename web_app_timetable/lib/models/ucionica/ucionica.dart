import 'package:web_app_timetable/models/skola/skola_id.dart';

import 'ucionica_id.dart';

class Ucionica {
  final UcionicaId id;
  final String naslov;
  final SkolaId skolaId;

  Ucionica({
    required this.id,
    required this.naslov,
    required this.skolaId,
  });
}
