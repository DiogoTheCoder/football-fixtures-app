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
}