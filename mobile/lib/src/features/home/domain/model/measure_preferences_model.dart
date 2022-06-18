import 'package:basearch/src/features/home/domain/model/device_model.dart';

class MeasurePreferencesModel {
  final String temperature;
  final String humidity;
  final String moisture;
  final String luminosity;
  final DeviceModel device;
  MeasurePreferencesModel(
      {required this.temperature,
      required this.humidity,
      required this.luminosity,
      required this.moisture,
      required this.device});
  factory MeasurePreferencesModel.fromJson(Map<dynamic, dynamic> json) =>
      MeasurePreferencesModel(
          temperature: json["temperature"],
          humidity: json["humidity"],
          luminosity: json["luminosity"],
          moisture: json["moisture"],
          device: DeviceModel.fromJson(json["deviceDTO"]));
  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
        "luminosity": luminosity,
        "moisture": moisture,
        "deviceDTO": device.toJson()
      };
}
