import 'package:flutter/material.dart';
import 'package:football_fixtures/repos/area.dart';
import 'package:football_fixtures/ui/league_selection.dart';

void main() => runApp(FootballFixturesApp());

class FootballFixturesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Fixtures',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LeagueSelectionPage(
        title: 'Leagues',
        areaRepo: AreaRepo(),
      )
    );
  }
}