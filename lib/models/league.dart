import 'package:football_fixtures/models/area.dart';

class League {
  final int id;
  final String name;
  Area _area;

  League({this.id, this.name});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
    );
  }

  Area getArea() {
    return this._area;
  }

  void setArea(Area area) {
    this._area = area;
  }
}