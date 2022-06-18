import 'package:basearch/src/features/device/domain/model/mqtt_model.dart';

class DeviceConfigModel {
  final String? key;
  final MqttModel? mqtt;

  DeviceConfigModel({this.key, this.mqtt});

  factory DeviceConfigModel.fromJson(Map<dynamic, dynamic> json) =>
      DeviceConfigModel(
        key: json["key"],
        mqtt: MqttModel.fromJson(json["mqttDTO"]),
      );
  Map<String, dynamic> toJson() => {"key": key, "mqttDTO": mqtt};
}
