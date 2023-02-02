import 'package:intl/intl.dart';

class GetDateTime {
  static String getDateNow() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  static String getTimeNow() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute}:${now.second}";
  }

  static String getCodeDateTime() {
    final now = DateTime.now();
    return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}";
  }

  static String getWeek(DateTime dateTime)
  {
    String st = DateFormat('EEEE').format(dateTime);

    print(st);
    return st;
  }

  static String getDayMonday()
  {
        final now = DateTime.now();

final past = now.subtract(Duration(days: getIndexWeekNow()));


print("${past.year}-${past.month}-${past.day}"); // -1

return "${past.year}-${past.month}-${past.day}";
  }

  static int getIndexWeekNow()
  {
    return  indexWeek[getWeek(DateTime.now())] ?? 0;  
  }

  static int getIndexWeek(DateTime time)
  {
    return  indexWeek[getWeek(time)] ?? 0;  
  }

  static Map<String, int> indexWeek = {
    "Monday":0,
     "Tuesday":1,
      "Wednesday":2,
       "Thursday":3,
        "Friday":4,
         "Saturday":5,
          "Sunday":6,
  };
}
