import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResponseModel {
  final bool ok;
  final String message;

  ResponseModel({required this.message, required this.ok});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      ResponseModel(ok: json["ok"], message: json["message"]);
  Map<String, dynamic> toJson() => {"ok": ok, "message": message};
}
