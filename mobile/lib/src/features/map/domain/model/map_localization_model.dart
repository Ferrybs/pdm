class MapLocalizationModel {
  final num latitude;
  final num longitde;

  MapLocalizationModel({required this.latitude, required this.longitde});

  factory MapLocalizationModel.fromJson(Map<dynamic, dynamic> json) =>
      MapLocalizationModel(
          latitude: json["latitude"], longitde: json["longitude"]);
  Map<String, dynamic> toJson() =>
      {"latitude": latitude, "longitude": longitde};
}
