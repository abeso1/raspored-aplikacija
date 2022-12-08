import 'package:web_app_timetable/models/skola/skola_id.dart';

import 'predmet_id.dart';

class Predmet {
  final PredmetId id;
  final String naslov;
  final SkolaId skolaId;

  Predmet({
    required this.id,
    required this.naslov,
    required this.skolaId,
  });
}
