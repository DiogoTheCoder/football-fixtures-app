import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_fixtures/models/league.dart';
import 'package:football_fixtures/repos/area.dart';
import 'package:football_fixtures/repos/league.dart';
import 'package:football_fixtures/ui/fixtures.dart';

class LeagueSelectionPage extends StatefulWidget {
  LeagueSelectionPage({Key key, this.title, this.areaRepo}) : super(key: key);
  final String title;
  final AreaRepo areaRepo;

  @override
  _LeagueSelectionPageState createState() => _LeagueSelectionPageState();
}

class _LeagueSelectionPageState extends State<LeagueSelectionPage> {
  LeagueRepo _leagueRepo;

  @override
  void initState() {
    super.initState();
  }

  Future<List<League>> getLeagues(BuildContext context) async {
    _leagueRepo = LeagueRepo();
    await widget.areaRepo.getAreas(context);
    return _leagueRepo.getLeagues(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: getLeagues(context),
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
                    List<League> _leagues = snapshot.data;
                    return ListView.builder(
                      itemCount: _leagues.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            leagueCard(context, _leagues[index]),
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

Widget leagueCard(BuildContext context, League league) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FixturesPage(league: league)),
      );
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    league.name,
                    minFontSize: 20,
                    maxLines: 1,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                  AutoSizeText.rich(
                    TextSpan(text: league.getArea().name),
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    minFontSize: 14,
                    maxLines: 1,
                  ),
                ],
              ),
              SvgPicture.network(
                league.getArea()?.ensignUrl,
                width: 64,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}