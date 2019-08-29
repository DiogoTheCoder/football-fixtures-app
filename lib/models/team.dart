class Team {
  final int id;
  final String name;

  Team({this.id, this.name});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
    );
  }
}