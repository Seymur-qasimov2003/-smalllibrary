import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Calculator {
  ///timestamp date time format
  static Timestamp gettimestampfromdatetime(DateTime datetime) {
    return Timestamp.fromDate(datetime);
  }

  ///datetime timestamp format
  static DateTime getdatetimefromtimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }

  ///datetimetostring
  static String getstringfromdatetime(DateTime datetime) {
    String formattime = DateFormat('dd-MM-yyyy').format(datetime);
    return formattime;
  }
}
