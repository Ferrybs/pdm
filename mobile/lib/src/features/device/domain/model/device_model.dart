class DeviceModel {
  DeviceModel({required this.id, required this.name});
  String id;
  String name;

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      DeviceModel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
