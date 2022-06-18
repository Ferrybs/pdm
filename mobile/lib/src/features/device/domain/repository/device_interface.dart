import 'package:basearch/src/features/device/domain/model/client_model.dart';
import 'package:basearch/src/features/device/domain/model/device_config_model.dart';

abstract class IDevice {
  Future<DeviceConfigModel?> getDeviceConfigs(String token);
  Future<ClientModel?> getClient(String token);
}
