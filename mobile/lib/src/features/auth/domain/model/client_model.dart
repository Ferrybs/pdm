import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/person.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ClientModel {
  final String? id;
  final Credentials? credentials;
  final Person? person;

  ClientModel({this.id, this.credentials, this.person});

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      id: json["id"],
      credentials: json["credentialsDTO"],
      person: json["personDTO"]);
  Map<String, dynamic> toJson() =>
      {"id": id, "credentialsDTO": credentials, "personDTO": person};
}
