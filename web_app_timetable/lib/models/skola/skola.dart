import 'package:web_app_timetable/models/skola/skola_id.dart';

class Skola {
  final String naziv;
  final String adresa;
  final String email;
  final String lozinka;
  final SkolaId id;

  Skola({
    required this.naziv,
    required this.adresa,
    required this.email,
    required this.lozinka,
    required this.id,
  });
}
