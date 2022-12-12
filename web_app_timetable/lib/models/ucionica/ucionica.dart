import 'package:web_app_timetable/models/skola/skola_id.dart';

import 'ucionica_id.dart';

class Ucionica {
  final UcionicaId? id;
  final String naslov;
  final SkolaId? skolaId;

  Ucionica({
    this.id,
    required this.naslov,
    this.skolaId,
  });

  Map<String, String> toJson() {
    return {
      'name': naslov,
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
    return other is Ucionica && other.naslov == naslov;
  }

  @override
  int get hashCode => naslov.hashCode;
}

Ucionica ucionicaFromJson(Map json) {
  return Ucionica(naslov: json['name']!);
}
