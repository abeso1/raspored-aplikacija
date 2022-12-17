import 'package:flutter/material.dart';
import '../models/skola/skola.dart';
import '../models/skola/skola_id.dart';

class SkoleNotifier extends ChangeNotifier {
  List<Skola> skole = [
    Skola(
      id: SkolaId(value: 1),
      naziv: 'Srednja Škola Travnik',
      adresa: 'Travnička bb, Travnik',
      email: 'skola@admin.com',
      lozinka: 'skola1234',
    ),
  ];

  removeSkolu(SkolaId skolaId) {
    skole.removeWhere((element) => element.id == skolaId);
    notifyListeners();
  }

  addSkolu() async {
    await Future.delayed(const Duration(seconds: 1));
    skole.add(
      Skola(
        id: SkolaId(value: 1),
        naziv: nazivDialog!,
        adresa: adresaDialog!,
        email: emailDialog!,
        lozinka: lozinkaDialog!,
      ),
    );
    notifyListeners();
  }

  String? nazivDialog;

  setNazivDialog(String? value) {
    nazivDialog = value;
    notifyListeners();
  }

  String? adresaDialog;

  setAdresaDialog(String? value) {
    adresaDialog = value;
    notifyListeners();
  }

  String? emailDialog;

  setEmailDialog(String? value) {
    emailDialog = value;
    notifyListeners();
  }

  String? lozinkaDialog;

  setLozinkaDialog(String? value) {
    lozinkaDialog = value;
    notifyListeners();
  }
}
