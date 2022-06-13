class PersonModel {
  PersonModel({required this.name, required this.lastName, required this.id});
  final String id;
  final String name;
  final String lastName;

  factory PersonModel.fromJson(Map<dynamic, dynamic> json) => PersonModel(
      id: json['id'], name: json["name"], lastName: json["lastName"]);

  Map<String, dynamic> toJson() => {"name": name, "lastName": lastName};
}
