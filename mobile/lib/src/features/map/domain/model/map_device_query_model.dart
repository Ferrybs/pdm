class MapDeviceQueryModel {
  final String id;
  final double latitude;
  final double longitude;
  final int distance;

  MapDeviceQueryModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });

  factory MapDeviceQueryModel.fromJson(Map<dynamic, dynamic> json) =>
      MapDeviceQueryModel(
          id: json["id"],
          latitude: json["latitude"],
          longitude: json["langitude"],
          distance: json["distance"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance
      };
}
