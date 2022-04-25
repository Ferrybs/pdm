class PersonModel {
  PersonModel({this.name, this.lastName});
  final String? name;
  final String? lastName;

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      PersonModel(name: json["name"], lastName: json["lastName"]);

  Map<String, dynamic> toJson() => {"name": name, "lastName": lastName};
}
