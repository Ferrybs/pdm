class DeviceModel {
  final String id;
  final String name;
  DeviceModel({required this.id, required this.name});

  factory DeviceModel.fromJson(Map<dynamic, dynamic> json) =>
      DeviceModel(id: json["id"], name: json["name"]);
  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
