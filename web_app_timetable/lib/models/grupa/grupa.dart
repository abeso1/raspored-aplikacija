import 'package:web_app_timetable/models/skola/skola_id.dart';

import 'grupa_id.dart';

class Grupa {
  final GrupaId id;
  final String naslov;
  final SkolaId skolaId;

  Grupa({
    required this.id,
    required this.naslov,
    required this.skolaId,
  });
}
