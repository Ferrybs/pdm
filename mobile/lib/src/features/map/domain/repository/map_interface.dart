import 'package:basearch/src/features/map/domain/model/device_map_model.dart';
import 'package:basearch/src/features/map/domain/model/device_model.dart';
import 'package:basearch/src/features/map/domain/model/map_device_query_model.dart';
import 'package:basearch/src/features/map/domain/model/map_localization_model.dart';

abstract class Imap {
  Future<List<DeviceModel>> getDevices(String token);
  Future<MapLocalizationModel> getDeviceLocalization(
      String token, String deviceId);
  Future<List<DeviceMapModel>> getMapDevices(
      String token, MapDeviceQueryModel query);
}
