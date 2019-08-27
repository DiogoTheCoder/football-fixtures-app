import 'package:football_fixtures/keys.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static const X_AUTH_TOKEN_HEADER = 'X-Auth-Token';

  static Future<http.Response> fetch(String url) {
    return http.get(
      url,
      headers: {X_AUTH_TOKEN_HEADER: Keys.FOOTBALL_DATA_API_KEY},
    );
  }
}