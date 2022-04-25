import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResponseModel {
  final bool? ok;

  ResponseModel({this.ok});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      ResponseModel(ok: json["ok"]);
  Map<String, dynamic> toJson() => {"ok": ok};
}
