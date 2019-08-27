import 'dart:convert';
import 'package:football_fixtures/config.dart';
import 'package:football_fixtures/controllers/api.dart';
import 'package:football_fixtures/models/area.dart';
import 'package:football_fixtures/models/league.dart';
import 'package:football_fixtures/repos/area.dart';

class LeagueRepo {
  Future<List<League>> getLeagues(context) async {
    String url = Config.baseUrl + '?areas=';
    for (Area area in AreaRepo.getList()) {
      url = url + "${area.id},";
    }

    var result = await ApiController.fetch(url);
    final List<League> leagues = [];
    for (var league in json.decode(result.body)['competitions']) {
      var date = league['currentSeason']['endDate'];
      if (!DateTime.parse(date).difference(DateTime.now()).isNegative) {
        League leagueObj = League.fromJson(league);
        List<Area> _areas = AreaRepo.getList();
        for (Area area in _areas) {
          if (league['area']['id'] == area.id) {
            leagueObj.setArea(area);
            break;
          }
        }

        leagues.add(leagueObj);
      }
    }

    return leagues;
  }
}