import 'package:basearch/src/features/device/domain/model/mqtt_model.dart';
import 'package:basearch/src/features/device/domain/model/wifi_model.dart';

class BluDeviceConfigModel {
  final String id;
  final String key;
  final String name;
  final WifiModel wifi;
  final MqttModel mqtt;

  BluDeviceConfigModel(
      {required this.id,
      required this.key,
      required this.name,
      required this.wifi,
      required this.mqtt});

  factory BluDeviceConfigModel.fromJson(Map<dynamic, dynamic> json) =>
      BluDeviceConfigModel(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        wifi: WifiModel.fromJson(json["wifiDTO"]),
        mqtt: MqttModel.fromJson(json["mqttDTO"]),
      );
  Map<String, dynamic> toJson() => {
        '"id"': '"' + id + '"',
        '"key"': '"' + key + '"',
        '"name"': '"' + name + '"',
        '"wifiDTO"': wifi.toJson(),
        '"mqttDTO"': mqtt.toJson()
      };
}
