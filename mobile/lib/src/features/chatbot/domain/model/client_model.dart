import 'person_model.dart';

class ClientModel {
  final String id;
  final PersonModel person;

  ClientModel({required this.id, required this.person});

  factory ClientModel.fromJson(Map<dynamic, dynamic> json) => ClientModel(
      id: json["id"], person: PersonModel.fromJson(json["personDTO"]));
  Map<String, dynamic> toJson() => {"id": id, "personDTO": person};
}
