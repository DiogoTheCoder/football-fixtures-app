import 'package:football_fixtures/enums/score_type.dart';

class Score {
  final ScoreType type;
  final int homeTeamScore;
  final int awayTeamScore;

  Score({this.type, this.homeTeamScore, this.awayTeamScore});

  factory Score.fromJson(Map<String, dynamic> json, ScoreType type) {
    return Score(
      type: type,
      homeTeamScore: json['homeTeam'],
      awayTeamScore: json['awayTeam'],
    );
  }
}