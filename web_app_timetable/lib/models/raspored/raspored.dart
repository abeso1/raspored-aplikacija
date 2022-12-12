import 'package:web_app_timetable/models/grupa/grupa_id.dart';
import 'package:web_app_timetable/models/nastavnik/nastavnik_id.dart';
import 'package:web_app_timetable/models/predmet/predmet_id.dart';
import 'package:web_app_timetable/models/raspored/raspored_id.dart';
import 'package:web_app_timetable/models/termin/termin.dart';
import 'package:web_app_timetable/models/ucionica/ucionica.dart';

class Raspored {
  final RasporedId id;
  final PredmetId predmetId;
  final NastavnikId nastavnikId;
  final GrupaId grupaId;
  final Termin termin;
  final Ucionica ucionica;

  Raspored({
    required this.id,
    required this.predmetId,
    required this.nastavnikId,
    required this.grupaId,
    required this.termin,
    required this.ucionica,
  });

  /*@override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Raspored &&
        other.predmetId == predmetId &&
        other.nastavnikId == nastavnikId &&
        other.grupaId == grupaId &&
        other.termin == termin &&
        other.ucionica == ucionica;
  }

  @override
  int get hashCode => id.hashCode;*/
}
