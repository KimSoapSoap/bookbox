import 'package:intl/intl.dart';

class DateUtil {
  static String format(String? date) {
    if (date == null) {
      return "";
    }
    DateTime dt = DateTime.parse(date);
    String formatDt = DateFormat("yy-MM-dd").format(dt);
    return formatDt;
  }
}
