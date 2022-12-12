//import 'dart:convert';

//import 'package:http/http.dart' as http;

class RasporedClient {
  Future<String?> createRaspored({
    required List<Map<String, String>> timeslotList,
    required List<Map<String, String>> roomList,
    required List<Map<String, int>> lessonList,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      /*print(jsonEncode(
        {
          'timeslotList': timeslotList,
          'roomList': roomList,
          'lessonList': lessonList,
        },
      ));*/
      /*var response = await http.post(
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
      );*/

      //if (response.statusCode == 200) {
      return '''
{
    "timeslotList": [
        {
            "dayOfWeek": "MONDAY",
            "startTime": "08:00:00",
            "endTime": "08:45:00"
        },
        {
            "dayOfWeek": "MONDAY",
            "startTime": "08:50:00",
            "endTime": "09:35:00"
        },
        {
            "dayOfWeek": "MONDAY",
            "startTime": "09:40:00",
            "endTime": "10:25:00"
        },
        {
            "dayOfWeek": "MONDAY",
            "startTime": "10:40:00",
            "endTime": "11:25:00"
        },
        {
            "dayOfWeek": "MONDAY",
            "startTime": "11:30:00",
            "endTime": "12:15:00"
        },
        {
            "dayOfWeek": "MONDAY",
            "startTime": "12:20:00",
            "endTime": "13:05:00"
        },
        {
            "dayOfWeek": "MONDAY",
            "startTime": "13:10:00",
            "endTime": "13:55:00"
        },
        {
            "dayOfWeek": "TUESDAY",
            "startTime": "08:00:00",
            "endTime": "08:45:00"
        },
        {
            "dayOfWeek": "TUESDAY",
            "startTime": "08:50:00",
            "endTime": "09:35:00"
        },
        {
            "dayOfWeek": "TUESDAY",
            "startTime": "09:40:00",
            "endTime": "10:25:00"
        },
        {
            "dayOfWeek": "TUESDAY",
            "startTime": "10:40:00",
            "endTime": "11:25:00"
        },
        {
            "dayOfWeek": "TUESDAY",
            "startTime": "11:30:00",
            "endTime": "12:15:00"
        },
        {
            "dayOfWeek": "TUESDAY",
            "startTime": "12:20:00",
            "endTime": "13:05:00"
        },
        {
            "dayOfWeek": "TUESDAY",
            "startTime": "13:10:00",
            "endTime": "13:55:00"
        },
        {
            "dayOfWeek": "WEDNESDAY",
            "startTime": "08:00:00",
            "endTime": "08:45:00"
        },
        {
            "dayOfWeek": "WEDNESDAY",
            "startTime": "08:50:00",
            "endTime": "09:35:00"
        },
        {
            "dayOfWeek": "WEDNESDAY",
            "startTime": "09:40:00",
            "endTime": "10:25:00"
        },
        {
            "dayOfWeek": "WEDNESDAY",
            "startTime": "10:40:00",
            "endTime": "11:25:00"
        },
        {
            "dayOfWeek": "WEDNESDAY",
            "startTime": "11:30:00",
            "endTime": "12:15:00"
        },
        {
            "dayOfWeek": "WEDNESDAY",
            "startTime": "12:20:00",
            "endTime": "13:05:00"
        },
        {
            "dayOfWeek": "WEDNESDAY",
            "startTime": "13:10:00",
            "endTime": "13:55:00"
        },
        {
            "dayOfWeek": "THURSDAY",
            "startTime": "08:00:00",
            "endTime": "08:45:00"
        },
        {
            "dayOfWeek": "THURSDAY",
            "startTime": "08:50:00",
            "endTime": "09:35:00"
        },
        {
            "dayOfWeek": "THURSDAY",
            "startTime": "09:40:00",
            "endTime": "10:25:00"
        },
        {
            "dayOfWeek": "THURSDAY",
            "startTime": "10:40:00",
            "endTime": "11:25:00"
        },
        {
            "dayOfWeek": "THURSDAY",
            "startTime": "11:30:00",
            "endTime": "12:15:00"
        },
        {
            "dayOfWeek": "THURSDAY",
            "startTime": "12:20:00",
            "endTime": "13:05:00"
        },
        {
            "dayOfWeek": "THURSDAY",
            "startTime": "13:10:00",
            "endTime": "13:55:00"
        },
        {
            "dayOfWeek": "FRIDAY",
            "startTime": "08:00:00",
            "endTime": "08:45:00"
        },
        {
            "dayOfWeek": "FRIDAY",
            "startTime": "08:50:00",
            "endTime": "09:35:00"
        },
        {
            "dayOfWeek": "FRIDAY",
            "startTime": "09:40:00",
            "endTime": "10:25:00"
        },
        {
            "dayOfWeek": "FRIDAY",
            "startTime": "10:40:00",
            "endTime": "11:25:00"
        },
        {
            "dayOfWeek": "FRIDAY",
            "startTime": "11:30:00",
            "endTime": "12:15:00"
        },
        {
            "dayOfWeek": "FRIDAY",
            "startTime": "12:20:00",
            "endTime": "13:05:00"
        },
        {
            "dayOfWeek": "FRIDAY",
            "startTime": "13:10:00",
            "endTime": "13:55:00"
        }
    ],
    "roomList": [
        {
            "name": "Učionica 1"
        },
        {
            "name": "Učionica 2"
        },
        {
            "name": "Učionica 3"
        },
        {
            "name": "Učionica 4"
        },
        {
            "name": "Učionica 5"
        },
        {
            "name": "Učionica 6"
        },
        {
            "name": "Učionica 7"
        },
        {
            "name": "Učionica 8"
        },
        {
            "name": "Učionica 9"
        }
    ],
    "lessonList": [
        {
            "id": 211,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 212,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 213,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 214,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 215,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 221,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 222,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 223,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 224,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 225,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 231,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 232,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 241,
            "subject": "5",
            "teacher": "4",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 242,
            "subject": "5",
            "teacher": "4",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 251,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 252,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 261,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 262,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 263,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 264,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 265,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 271,
            "subject": "6",
            "teacher": "15",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 272,
            "subject": "6",
            "teacher": "15",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 273,
            "subject": "6",
            "teacher": "15",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 274,
            "subject": "6",
            "teacher": "15",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 275,
            "subject": "6",
            "teacher": "15",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 281,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 282,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 291,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 292,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 301,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 8"
            }
        },
        {
            "id": 302,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 311,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 312,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 321,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 322,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 331,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 332,
            "subject": "9",
            "teacher": "11",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 341,
            "subject": "12",
            "teacher": "10",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 351,
            "subject": "12",
            "teacher": "10",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 361,
            "subject": "12",
            "teacher": "10",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 371,
            "subject": "12",
            "teacher": "10",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 381,
            "subject": "12",
            "teacher": "10",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 391,
            "subject": "12",
            "teacher": "10",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 401,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 402,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 403,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 404,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 405,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 411,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 412,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 413,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 414,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 8"
            }
        },
        {
            "id": 415,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 421,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 422,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 423,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 424,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 425,
            "subject": "4",
            "teacher": "14",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 431,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 432,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 433,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 434,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 435,
            "subject": "4",
            "teacher": "1",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 441,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 442,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 443,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 444,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 445,
            "subject": "6",
            "teacher": "2",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 451,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 452,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 453,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 454,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 455,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 461,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 462,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 463,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 464,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 465,
            "subject": "4",
            "teacher": "2",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 471,
            "subject": "15",
            "teacher": "7",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 481,
            "subject": "15",
            "teacher": "7",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 491,
            "subject": "15",
            "teacher": "7",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 501,
            "subject": "15",
            "teacher": "7",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 511,
            "subject": "15",
            "teacher": "7",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 521,
            "subject": "15",
            "teacher": "7",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 531,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 532,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 541,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 542,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 551,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 552,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 561,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 562,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 571,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 572,
            "subject": "10",
            "teacher": "5",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 581,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 582,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 8"
            }
        },
        {
            "id": 591,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 592,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 601,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 602,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 611,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 612,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        },
        {
            "id": 621,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 622,
            "subject": "5",
            "teacher": "3",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 631,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 632,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 641,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 642,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 651,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 652,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 661,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 662,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 671,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 672,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 681,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 682,
            "subject": "3",
            "teacher": "13",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 691,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 692,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 701,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 702,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 711,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 712,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 721,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 8"
            }
        },
        {
            "id": 722,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 731,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 732,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 741,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 742,
            "subject": "11",
            "teacher": "9",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 3"
            }
        },
        {
            "id": 751,
            "subject": "1",
            "teacher": "8",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 761,
            "subject": "1",
            "teacher": "8",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 771,
            "subject": "1",
            "teacher": "8",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 8"
            }
        },
        {
            "id": 781,
            "subject": "1",
            "teacher": "8",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 791,
            "subject": "1",
            "teacher": "8",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 801,
            "subject": "1",
            "teacher": "8",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 811,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 812,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 813,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 821,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 822,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 823,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 831,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 832,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 833,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 841,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 842,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 843,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "10:40:00",
                "endTime": "11:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 851,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 852,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 853,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 861,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 1"
            }
        },
        {
            "id": 862,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 863,
            "subject": "7",
            "teacher": "12",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 6"
            }
        },
        {
            "id": 871,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 872,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "1",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 4"
            }
        },
        {
            "id": 881,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "12:20:00",
                "endTime": "13:05:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 882,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "2",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 891,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "TUESDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 892,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "3",
            "timeslot": {
                "dayOfWeek": "WEDNESDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 901,
            "subject": "7",
            "teacher": "6",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "MONDAY",
                "startTime": "11:30:00",
                "endTime": "12:15:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 902,
            "subject": "7",
            "teacher": "6",
            "studentGroup": "4",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "13:10:00",
                "endTime": "13:55:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 911,
            "subject": "7",
            "teacher": "6",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 7"
            }
        },
        {
            "id": 912,
            "subject": "7",
            "teacher": "6",
            "studentGroup": "5",
            "timeslot": {
                "dayOfWeek": "THURSDAY",
                "startTime": "09:40:00",
                "endTime": "10:25:00"
            },
            "room": {
                "name": "Učionica 5"
            }
        },
        {
            "id": 921,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:00:00",
                "endTime": "08:45:00"
            },
            "room": {
                "name": "Učionica 9"
            }
        },
        {
            "id": 922,
            "subject": "8",
            "teacher": "6",
            "studentGroup": "6",
            "timeslot": {
                "dayOfWeek": "FRIDAY",
                "startTime": "08:50:00",
                "endTime": "09:35:00"
            },
            "room": {
                "name": "Učionica 2"
            }
        }
    ],
    "score": "0hard/0soft"
}
''';
      //}
      //return null;
    } catch (e) {
      return null;
    }
  }
}
