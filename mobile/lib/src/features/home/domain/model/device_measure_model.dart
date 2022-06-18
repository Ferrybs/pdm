import 'package:basearch/src/features/home/domain/model/device_model.dart';

class DevicePreferencesModel {
  final String temperature;
  final String humidity;
  final String moisture;
  final String luminosity;
  DevicePreferencesModel({
    required this.temperature,
    required this.humidity,
    required this.luminosity,
    required this.moisture,
  });
  factory DevicePreferencesModel.fromJson(Map<dynamic, dynamic> json) =>
      DevicePreferencesModel(
        temperature: json["temperature"],
        humidity: json["humidity"],
        luminosity: json["luminosity"],
        moisture: json["moisture"],
      );
  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
        "luminosity": luminosity,
        "moisture": moisture,
      };
}
