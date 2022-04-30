class TokenDataModel {
  final bool? ok;

  TokenDataModel({this.ok});

  factory TokenDataModel.fromJson(Map<String, dynamic> json) =>
      TokenDataModel(ok: json["ok"]);
  Map<String, dynamic> toJson() => {"ok": ok};
}
