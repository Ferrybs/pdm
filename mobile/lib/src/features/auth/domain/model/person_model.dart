class PersonModel {
  PersonModel({required this.name, required this.lastName});
  final String name;
  final String lastName;

  factory PersonModel.fromJson(Map<dynamic, dynamic> json) =>
      PersonModel(name: json["name"], lastName: json["lastName"]);

  Map<String, dynamic> toJson() => {"name": name, "lastName": lastName};
}
