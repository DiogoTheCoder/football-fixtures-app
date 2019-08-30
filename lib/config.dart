import 'package:intl/intl.dart';

class Config {
  static DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  static String baseUrl = 'https://api.football-data.org/v2/';

  static String getCurrentDate() {
    return Config.dateFormatter.format(DateTime.now());
  }

  static String getFutureDate(Duration addDays) {
    return Config.dateFormatter.format(DateTime.now().add(addDays));
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