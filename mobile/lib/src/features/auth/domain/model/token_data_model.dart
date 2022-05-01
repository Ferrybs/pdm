class TokenDataModel {
  final String? token;
  final int? expiresIn;
  final int? iat;

  TokenDataModel({this.token, this.expiresIn, this.iat});

  factory TokenDataModel.fromJson(Map<String, dynamic> json) => TokenDataModel(
      token: json["token"], expiresIn: json["expiresIn"], iat: json["iat"]);
  Map<String, dynamic> toJson() =>
      {"token": token, "expiresIn": expiresIn, "iat": iat};
}
