class Area {
  final int id;
  final String code;
  final String name;
  final String ensignUrl;

  Area({this.id, this.code, this.name, this.ensignUrl});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      code: json['countryCode'],
      name: json['name'],
      ensignUrl: json['ensignUrl'],
    );
  }
}