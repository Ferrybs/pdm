import 'package:basearch/src/features/device/data/repository/repository_base.dart';
import 'package:basearch/src/features/device/domain/model/client_model.dart';
import 'package:basearch/src/features/device/domain/model/device_config_model.dart';
import 'package:basearch/src/features/device/domain/repository/device_interface.dart';
import 'package:dio/dio.dart';

class DeviceRepository extends DeviceRepositoryBase implements IDevice {
  @override
  Future<ClientModel?> getClient(String token) async {
    try {
      Response response;
      var dio = Dio(deviceOptions);
      response = await dio.get("/client/",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      if (response.statusCode == 200) {
        return ClientModel.fromJson(response.data["clientDTO"]);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeviceConfigModel?> getDeviceConfigs(String token) async {
    try {
      Response response;
      var dio = Dio(deviceOptions);
      response = await dio.get('/device/configs',
          options: Options(headers: {"Authorization": "Bearer " + token}));
      if (response.statusCode == 200) {
        return DeviceConfigModel.fromJson(response.data["configsDTO"]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
