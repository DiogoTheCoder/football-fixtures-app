import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:football_fixtures/config.dart';
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
                    DateTime lastFixtureDate = Config.stringToDateTime(_fixtures.first.utcDate).toLocal();
                    return ListView.builder(
                      itemCount: _fixtures.length,
                      itemBuilder: (BuildContext context, int index) {
                        Fixture currentFixture = _fixtures[index];
                        DateTime fixtureDate = Config.stringToDateTime(currentFixture.utcDate).toLocal();
                        Widget fixtureCard = fixtureDaySection(context, currentFixture, fixtureDate, lastFixtureDate, index);
                        lastFixtureDate = fixtureDate;

                        return fixtureCard;
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

/// Since we only get one week worth of fixtures,
/// we can get away with just checking the day
Widget fixtureDaySection(BuildContext context, Fixture fixture, DateTime fixtureDate, DateTime lastFixtureDate, int index) {
  if (index == 0) {
    return Column(
      children: <Widget>[
        Divider(),
        AutoSizeText(
          fixture.getDateFormatted()
        ),
        Divider(),
        fixtureCard(context, fixture),
      ],
    );
  }

  if (lastFixtureDate.day != fixtureDate.day) {
    return Column(
      children: <Widget>[
        Divider(),
        AutoSizeText(
          fixture.getDateFormatted()
        ),
        Divider(),
        fixtureCard(context, fixture),
      ],
    );
  } else {
    return Column(
      children: <Widget>[
        fixtureCard(context, fixture),
      ],
    );
  }
}

Widget fixtureCard(BuildContext context, Fixture fixture) {
  Color borderColor = Colors.purple;
  return InkWell(
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => FixturesPage(league: league)),
      // );
    },
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Container(
        height: 96,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 92,
                child: AutoSizeText(
                  fixture.getTeam(TeamType.HOME).name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  fixture.getTimeFormatted(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              Container(
                width: 92,
                child: AutoSizeText(
                  fixture.getTeam(TeamType.AWAY).name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );}