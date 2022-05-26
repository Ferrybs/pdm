import 'package:basearch/src/features/device/domain/model/mqtt_model.dart';
import 'package:basearch/src/features/device/domain/model/wifi_model.dart';

class DeviceConfigModel {
  final WifiModel? wifi;
  final MqttModel? mqtt;

  DeviceConfigModel({this.wifi, this.mqtt});

  factory DeviceConfigModel.fromJson(Map<dynamic, dynamic> json) =>
      DeviceConfigModel(
          wifi: WifiModel.fromJson(json["wifiDTO"]),
          mqtt: MqttModel.fromJson(json["mqttDTO"]));
  Map<String, dynamic> toJson() => {"wifiDTO": wifi, "mqttDTO": mqtt};
}
