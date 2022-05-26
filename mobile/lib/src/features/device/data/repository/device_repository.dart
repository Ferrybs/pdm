import 'package:basearch/src/features/device/data/dto/response_model.dart';
import 'package:basearch/src/features/device/data/repository/repository_base.dart';
import 'package:basearch/src/features/device/domain/model/device_config_model.dart';
import 'package:basearch/src/features/device/domain/model/mqtt_model.dart';
import 'package:basearch/src/features/device/domain/repository/device_interface.dart';
import 'package:basearch/src/features/device/domain/model/device_model.dart';
import 'package:dio/dio.dart';

class DeviceRepository extends DeviceRepositoryBase implements IDevice {
  @override
  Future<DeviceModel?> getDeviceId() async {
    try {
      Response response;
      var dio = Dio(deviceOptions);
      response = await dio.get('');
      if (response.statusCode == 200) {
        final data = ResponseModel.fromJson(response.data);
        if (data.ok == true) {
          var device = DeviceModel.fromJson(response.data);
          return device;
        }
      }
      return null;
    } on DioError catch (e) {
      return null;
    }
  }

  @override
  Future<bool> postDeviceConfig(DeviceConfigModel deviceConfigModel) async {
    try {
      Response response;
      var dio = Dio(deviceOptions);
      response = await dio.post('', data: deviceConfigModel.toJson());
      if (response.statusCode == 200) {
        final data = ResponseModel.fromJson(response.data);
        if (data.ok == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<MqttModel?> getMqttModel(String token) async {
    try {
      Response response;
      var dio = Dio(deviceOptions);
      response = await dio.get('/mqtt',
          options: Options(headers: {"Authorization": "Bearer " + token}));
      if (response.statusCode == 200) {
        final data = ResponseModel.fromJson(response.data);
        if (data.ok == true) {
          var mqttModel = MqttModel.fromJson(response.data["mqttDTO"]);
          return mqttModel;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
