class CredentialsModel {
  CredentialsModel({required this.email});
  final String email;

  factory CredentialsModel.fromJson(Map<String, dynamic> json) =>
      CredentialsModel(email: json["email"]);

  Map<String, dynamic> toJson() => {"email": email};
}
