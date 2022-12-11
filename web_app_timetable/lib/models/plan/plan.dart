import 'package:web_app_timetable/models/grupa/grupa_id.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/models/plan/plan_id.dart';
import 'package:web_app_timetable/models/predmet/predmet_id.dart';
import 'package:web_app_timetable/models/skola/skola_id.dart';

class Plan {
  final PlanId id;
  final PredmetId predmetId;
  final NastavnikId nastavnikId;
  final GrupaId grupaId;
  final int brojCasova;
  final SkolaId skolaId;

  Plan({
    required this.id,
    required this.predmetId,
    required this.nastavnikId,
    required this.grupaId,
    required this.brojCasova,
    required this.skolaId,
  });
}
