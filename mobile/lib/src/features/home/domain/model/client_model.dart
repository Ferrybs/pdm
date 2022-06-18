import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ClientModel {
  final String id;
  final PersonModel person;

  ClientModel({required this.id, required this.person});

  factory ClientModel.fromJson(Map<dynamic, dynamic> json) => ClientModel(
      id: json["id"], person: PersonModel.fromJson(json["personDTO"]));
  Map<String, dynamic> toJson() => {"id": id, "personDTO": person.toJson()};
}
