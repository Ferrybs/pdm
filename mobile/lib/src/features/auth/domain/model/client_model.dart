import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ClientModel {
  final String? id;
  final CredentialsModel? credentials;
  final PersonModel? person;

  ClientModel({this.id, this.credentials, this.person});

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      id: json["id"],
      credentials: json["credentialsDTO"],
      person: json["personDTO"]);
  Map<String, dynamic> toJson() =>
      {"id": id, "credentialsDTO": credentials, "personDTO": person};
}
