class ResponseModel {
  final bool ok;
  final String message;

  ResponseModel({required this.ok, required this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      ResponseModel(ok: json["ok"], message: json["message"]);
  Map<String, dynamic> toJson() => {"ok": ok, "message": message};
}
