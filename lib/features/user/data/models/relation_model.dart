class RelationModel {
  final String name;
  final int id;

  RelationModel({
    required this.name,
    required this.id,
  });

  factory RelationModel.fromJson(Map<String, dynamic> json) {
    return RelationModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
