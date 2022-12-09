import 'package:web_app_timetable/models/skola/skola_id.dart';

import 'nastavnik_id.dart';

class Nastavnik {
  final NastavnikId id;
  final String naslov;
  final SkolaId skolaId;

  Nastavnik({
    required this.id,
    required this.naslov,
    required this.skolaId,
  });
}
