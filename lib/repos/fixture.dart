import 'dart:convert';
import 'package:football_fixtures/config.dart';
import 'package:football_fixtures/controllers/api.dart';
import 'package:football_fixtures/enums/score_type.dart';
import 'package:football_fixtures/enums/team.dart';
import 'package:football_fixtures/models/fixture.dart';
import 'package:football_fixtures/models/league.dart';
import 'package:football_fixtures/models/score.dart';
import 'package:football_fixtures/models/team.dart';

class FixtureRepo {
  Future<List<Fixture>> getFixtures(context, League league) async {
    String currentDate = Config.getCurrentDate();
    String futureDate = Config.getFutureDate(Duration(days: 7));

    var result = await ApiController.fetch(
      "${Config.baseUrl}matches?competitions=${league.id}&dateFrom=$currentDate&dateTo=$futureDate"
    );

    final List<Fixture> fixtures = [];
    for (var fixture in json.decode(result.body)['matches']) {
      Fixture fixtureObj = Fixture.fromJson(fixture);
      fixtureObj.setTeam(TeamType.HOME, Team.fromJson(fixture['homeTeam']));
      fixtureObj.setTeam(TeamType.AWAY, Team.fromJson(fixture['awayTeam']));

      Score scoreObj = Score.fromJson(fixture['score']['fullTime'], ScoreType.FULL_TIME);
      fixtureObj.setScore(scoreObj);

      fixtures.add(fixtureObj);
    }

    return fixtures;
  }
}