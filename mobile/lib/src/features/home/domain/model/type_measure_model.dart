class TypeMeasureModel {
  final String id;
  final String type;
  TypeMeasureModel({required this.id, required this.type});

  factory TypeMeasureModel.fromJson(Map<dynamic, dynamic> json) =>
      TypeMeasureModel(id: json["id"], type: json["type"]);
  Map<String, dynamic> toJson() => {"id": id, "type": type};
}
