import 'package:equatable/equatable.dart';

class RelationModel extends Equatable {
  final String name;
  final int id;

  const RelationModel({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [id, name];

  factory RelationModel.fromJson(Map<String, dynamic> json) {
    return RelationModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
