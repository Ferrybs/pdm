import 'package:basearch/src/features/device/domain/model/client_model.dart';
import 'package:basearch/src/features/device/domain/model/mqtt_model.dart';
import 'package:basearch/src/features/device/domain/model/wifi_model.dart';

class DeviceConfigModel {
  final String? id;
  final String? name;
  final String? key;
  final WifiModel? wifi;
  final MqttModel? mqtt;
  final ClientModel? client;

  DeviceConfigModel(
      {this.id, this.name, this.key, this.wifi, this.mqtt, this.client});

  factory DeviceConfigModel.fromJson(Map<dynamic, dynamic> json) =>
      DeviceConfigModel(
          id: json["id"],
          name: json["name"],
          key: json["key"],
          wifi: WifiModel.fromJson(json["wifiDTO"]),
          mqtt: MqttModel.fromJson(json["mqttDTO"]),
          client: ClientModel.fromJson(json["clientDTO"]));
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "key": key,
        "wifiDTO": wifi,
        "mqttDTO": mqtt,
        "clientDTO": client
      };
}
