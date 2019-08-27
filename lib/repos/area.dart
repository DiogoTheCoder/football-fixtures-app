import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:football_fixtures/models/area.dart';

class AreaRepo {
  static List<Area> _list = [];

  Future<List<Area>> getAreas(BuildContext context) async {
    List<Area> areas = [];
    String data = await DefaultAssetBundle.of(context).loadString('assets/areas.json');
    for (var area in json.decode(data)) {
      areas.add(Area.fromJson(area));
    }

    this._setList(areas);
    return areas;
  }

  static List<Area> getList() {
    return AreaRepo._list;
  }

  void _setList(List<Area> areas) {
    AreaRepo._list = areas.toList();
  }
}