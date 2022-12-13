import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RasporedClient {
  Future<Uint8List?> createRaspored({
    required List<Map<String, String>> timeslotList,
    required List<Map<String, String>> roomList,
    required List<Map<String, int>> lessonList,
  }) async {
    try {
      var response = await http
          .post(
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
          )
          .timeout(const Duration(minutes: 10));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
