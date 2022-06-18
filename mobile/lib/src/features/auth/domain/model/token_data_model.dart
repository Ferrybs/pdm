class TokenDataModel {
  final String token;
  final int expiresIn;
  final int iat;

  TokenDataModel(
      {required this.token, required this.expiresIn, required this.iat});

  factory TokenDataModel.fromJson(Map<String, dynamic> json) => TokenDataModel(
      token: json["token"].toString(),
      expiresIn: int.parse(json["expiresIn"].toString()),
      iat: int.parse(json["iat"].toString()));
  Map<String, dynamic> toJson() =>
      {"token": token, "expiresIn": expiresIn, "iat": iat};
}
