import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:football_fixtures/enums/team.dart';
import 'package:football_fixtures/models/fixture.dart';
import 'package:football_fixtures/models/league.dart';
import 'package:football_fixtures/repos/fixture.dart';

class FixturesPage extends StatefulWidget {
  FixturesPage({Key key, this.league}) : super(key: key);
  final League league;

  _FixturesPageState createState() => _FixturesPageState();
}

class _FixturesPageState extends State<FixturesPage> {
  FixtureRepo _fixtureRepo;

  @override
  void initState() {
    super.initState();
    _fixtureRepo = FixtureRepo();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Fixtures'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: _fixtureRepo?.getFixtures(context, widget.league),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    List<Fixture> _fixtures = snapshot.data;
                    return ListView.builder(
                      itemCount: _fixtures.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            fixtureCard(context, _fixtures[index]),
                          ],
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
            }
          },
        ),
      ),
    );
  }
}

Widget fixtureCard(BuildContext context, Fixture fixture) {
  return InkWell(
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => FixturesPage(league: league)),
      // );
    },
    child: Card(
      child: Container(
        height: 96,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                fixture.getTeam(TeamType.HOME).name,
                maxFontSize: 12,
                maxLines: 2,
              ),
              AutoSizeText(
                fixture.getTeam(TeamType.AWAY).name,
                maxFontSize: 12,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    ),
  );}