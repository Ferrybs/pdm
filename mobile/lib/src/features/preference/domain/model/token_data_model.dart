class TokenDataModel {
  final String token;
  TokenDataModel({required this.token});

  factory TokenDataModel.fromJson(Map<dynamic, dynamic> json) =>
      TokenDataModel(token: json["token"]);

  Map<String, dynamic> toJson() => {"token": token};
}
