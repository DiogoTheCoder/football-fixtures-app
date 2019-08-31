import 'package:intl/intl.dart';

class Config {
  static DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  static String baseUrl = 'https://api.football-data.org/v2/';
  static List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static List<String> _months = ['Jan', 'Feb', 'March', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  static String getCurrentDate() {
    return Config._dateFormatter.format(DateTime.now());
  }

  static String getFutureDate(Duration addDays) {
    return Config._dateFormatter.format(DateTime.now().add(addDays));
  }

  static DateTime stringToDateTime(String dateTime) {
    return DateTime.parse(dateTime);
  }

  static String dayNumToString(int dayOfTheWeek) {
    return _days[dayOfTheWeek - 1];
  }

  static String monthNumToString(int month) {
    return _months[month - 1];
  }

  static String _parseEnum(enumItem) {
    if (enumItem == null) return null;
    return enumItem.toString().split('.')[1];
  }

  static enumFromString<T>(List<T> enumValues, String value) {
    if (value == null) return null;

    return enumValues.singleWhere(
      (enumItem) => _parseEnum(enumItem) == value,
      orElse: () => null);
  }
}