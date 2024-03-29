import 'package:football_fixtures/config.dart';
import 'package:football_fixtures/enums/match_status.dart';
import 'package:football_fixtures/enums/score_type.dart';
import 'package:football_fixtures/enums/team.dart';
import 'package:football_fixtures/enums/winner.dart';
import 'package:football_fixtures/models/score.dart';
import 'package:football_fixtures/models/team.dart';

class Fixture {
  final int id;
  final String utcDate;
  final MatchStatus status;
  Team _homeTeam;
  Team _awayTeam;
  Winner winningTeam;
  Score fullTimeScore;

  Fixture({this.id, this.utcDate, this.status, this.winningTeam});

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      utcDate: json['utcDate'],
      status: Config.enumFromString(MatchStatus.values, json['status']),
      winningTeam: Config.enumFromString(Winner.values, json['score']['winner']),
    );
  }

  void setTeam(TeamType type, Team team) {
    switch (type) {
      case TeamType.HOME:
        this._homeTeam = team;
        break;
      case TeamType.AWAY:
        this._awayTeam = team;
        break;
    }
  }

  Team getTeam(TeamType type) {
    switch (type) {
      case TeamType.HOME:
        return this._homeTeam;
        break;
      case TeamType.AWAY:
        return this._awayTeam;
        break;
      default:
        return null;
        break;
    }
  }

  void setWinningTeam(Winner team) {
    this.winningTeam = team;
  }

  void setScore(Score score) {
    switch (score.type) {
      case ScoreType.FULL_TIME:
        this.fullTimeScore = score;
        break;
      case ScoreType.HALF_TIME:
        // TODO: Handle this case.
        break;
      case ScoreType.EXTRA_TIME:
        // TODO: Handle this case.
        break;
      case ScoreType.PENALTIES:
        // TODO: Handle this case.
        break;
    }
  }

  String getTimeFormatted() {
    DateTime date = Config.stringToDateTime(this.utcDate).toLocal();
    return "${date.hour}:${date.minute}";
  }

  String getDateFormatted() {
    DateTime date = Config.stringToDateTime(this.utcDate).toLocal();
    return "${Config.dayNumToString(date.weekday)}, ${date.day} ${Config.monthNumToString(date.month)}";
  }

  String getScoreFormatted() {
    return "${this.fullTimeScore.homeTeamScore}  -  ${this.fullTimeScore.awayTeamScore}";
  }

  bool hasDrawn() {
    return this.winningTeam == Winner.DRAW;
  }

  bool hasHomeWon() {
    return this.winningTeam == Winner.HOME_TEAM;
  }
}