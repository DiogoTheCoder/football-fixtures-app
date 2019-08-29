import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:football_fixtures/keys.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static const X_AUTH_TOKEN_HEADER = 'X-Auth-Token';

  static Future<http.Response> fetch(String url, [bool cacheResponse, Duration duration]) async {
    var cachedFile = await DefaultCacheManager().getFileFromCache(url);
    if (cachedFile == null) {
      var resp = await http.get(
        url,
        headers: {X_AUTH_TOKEN_HEADER: Keys.FOOTBALL_DATA_API_KEY},
      );

      if (cacheResponse != null && duration != null) {
        DefaultCacheManager().putFile(
          url, resp.bodyBytes, maxAge: duration
        );
      }

      return resp;
    }

    return await getFileContent(cachedFile.file);
  }

  static Future<http.Response> getFileContent(File file) async {
    String fileContent = await file.readAsString();
    return http.Response(fileContent, HttpStatus.accepted);
  }
}