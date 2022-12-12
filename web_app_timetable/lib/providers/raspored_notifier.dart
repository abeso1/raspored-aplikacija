import 'package:flutter/material.dart';
import 'package:web_app_timetable/services/raspored_client.dart';
import 'termini_notifier.dart';
import 'nastavni_plan_notifier.dart';
import 'ucionice_notifier.dart';

class RasporedNotifier extends ChangeNotifier {
  final TerminiNotifier terminiNotifier;
  final UcioniceNotifier ucioniceNotifier;
  final NastavniPlanNotifier nastavniPlanNotifier;

  RasporedNotifier({
    required this.terminiNotifier,
    required this.ucioniceNotifier,
    required this.nastavniPlanNotifier,
  });

  bool getTerminiError = false;
  bool getTerminiLoading = true;

  Future<void> createRaspored() async {
    List<Map<String, String>> timeslotList = terminiNotifier.getTimeslotList();
    List<Map<String, String>> roomList = ucioniceNotifier.getRoomList();
    List<Map<String, int>> lessonList = nastavniPlanNotifier.getLessonList();

    await RasporedClient().createRaspored(
      roomList: roomList,
      timeslotList: timeslotList,
      lessonList: lessonList,
    );
  }
}
