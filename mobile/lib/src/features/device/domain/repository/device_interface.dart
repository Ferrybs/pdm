import 'package:basearch/src/features/device/domain/model/device_config_model.dart';
import 'package:basearch/src/features/device/domain/model/device_model.dart';
import 'package:basearch/src/features/device/domain/model/mqtt_model.dart';

abstract class IDevice {
  Future<DeviceModel?> getDeviceId();
  Future<bool> postDeviceConfig(DeviceConfigModel deviceConfigModel);
  Future<MqttModel?> getMqttModel(String token);
}
