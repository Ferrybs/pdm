import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';

class ClientModel {
  final String id;
  final CredentialsModel credentials;
  final PersonModel person;

  ClientModel(
      {required this.id, required this.credentials, required this.person});

  factory ClientModel.fromJson(Map<dynamic, dynamic> json) => ClientModel(
      id: json["id"],
      person: PersonModel.fromJson(json["personDTO"]),
      credentials: CredentialsModel.fromJson(json["credentialsDTO"]));
  Map<String, dynamic> toJson() =>
      {"id": id, "credentialsDTO": credentials, "personDTO": person};
}
