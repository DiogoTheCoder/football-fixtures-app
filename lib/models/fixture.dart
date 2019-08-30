import 'package:football_fixtures/config.dart';
import 'package:football_fixtures/enums/match_status.dart';
import 'package:football_fixtures/enums/team.dart';
import 'package:football_fixtures/models/team.dart';

class Fixture {
  final int id;
  final String utcDate;
  final MatchStatus status;
  Team _homeTeam;
  Team _awayTeam;

  Fixture({this.id, this.utcDate, this.status});

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      utcDate: json['utcDate'],
      status: Config.enumFromString(MatchStatus.values, json['status']),
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
}