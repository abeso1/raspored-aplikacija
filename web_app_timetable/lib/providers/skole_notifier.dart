import 'package:flutter/material.dart';
import 'package:web_app_timetable/services/skola_client.dart';
import '../models/skola/skola.dart';
import '../models/skola/skola_id.dart';

class SkoleNotifier extends ChangeNotifier {
  bool getSkoleError = false;
  bool getSkoleLoading = true;
  List<Skola> skole = [];
  Map<SkolaId, Skola> skoleMapped = {};

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

  getSkole() async {
    try {
      skole = await SkolaClient().getSkole();
      getSkoleLoading = false;
      getSkoleError = false;
    } catch (e) {
      getSkoleLoading = false;
      getSkoleError = true;
    }
    notifyListeners();
  }
}
