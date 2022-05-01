class PersonModel {
  PersonModel({this.name, this.lastName, this.id});
  final String? id;
  final String? name;
  final String? lastName;

  factory PersonModel.fromJson(Map<dynamic, dynamic> json) => PersonModel(
      id: json['id'], name: json["name"], lastName: json["lastName"]);

  Map<String, dynamic> toJson() => {"name": name, "lastName": lastName};
}
