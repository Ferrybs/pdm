import 'package:basearch/src/features/map/domain/model/device_model.dart';

abstract class Imap {
  Future<List<DeviceModel>> getDevices(String token);
}
