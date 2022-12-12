import 'dart:convert';

import 'package:http/http.dart' as http;

class RasporedClient {
  createRaspored({
    required List<Map<String, String>> timeslotList,
    required List<Map<String, String>> roomList,
    required List<Map<String, int>> lessonList,
  }) async {
    try {
      print(jsonEncode(
        {
          'timeslotList': timeslotList,
          'roomList': roomList,
          'lessonList': lessonList,
        },
      ));
      var response = await http.post(
        Uri.parse("https://logic.leftjoin.ba/timeTable/solve"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            'timeslotList': timeslotList,
            'roomList': roomList,
            'lessonList': lessonList,
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
