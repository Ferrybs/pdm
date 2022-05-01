import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResponseModel {
  final bool? ok;
  final String? message;

  ResponseModel({this.message, this.ok});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      ResponseModel(ok: json["ok"], message: json["message"]);
  Map<String, dynamic> toJson() => {"ok": ok, "message": message};
}
