class CredentialsModel {
  CredentialsModel({this.email, this.password});
  final String? email;
  final String? password;

  factory CredentialsModel.fromJson(Map<String, dynamic> json) =>
      CredentialsModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
