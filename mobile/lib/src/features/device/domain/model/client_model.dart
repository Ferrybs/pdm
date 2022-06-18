class ClientModel {
  final String? id;

  ClientModel({this.id});

  factory ClientModel.fromJson(Map<dynamic, dynamic> json) =>
      ClientModel(id: json["id"]);
  Map<String, dynamic> toJson() => {"id": id};
}
