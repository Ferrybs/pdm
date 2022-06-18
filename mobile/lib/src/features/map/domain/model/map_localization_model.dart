class MapLocalizationModel {
  final double latitude;
  final double longitde;

  MapLocalizationModel({required this.latitude, required this.longitde});

  factory MapLocalizationModel.fromJson(Map<dynamic, dynamic> json) =>
      MapLocalizationModel(
          latitude: double.parse(json["latitude"]),
          longitde: double.parse(json["longitude"]));
  Map<String, dynamic> toJson() =>
      {"latitude": latitude, "longitude": longitde};
}
