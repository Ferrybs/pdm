class MapPreferencesModel {
  final String humidity;
  final String luminosity;
  final String moisture;
  final String temperature;

  MapPreferencesModel({
    required this.humidity,
    required this.luminosity,
    required this.moisture,
    required this.temperature,
  });

  factory MapPreferencesModel.fromJson(Map<dynamic, dynamic> json) =>
      MapPreferencesModel(
          humidity: json["humidity"],
          luminosity: json["luminosity"],
          moisture: json["moisture"],
          temperature: json["temperature"]);
  Map<String, dynamic> toJson() => {
        "humidity": humidity,
        "luminosity": luminosity,
        "moisture": moisture,
        "temperature": temperature
      };
}
