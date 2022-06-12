import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/device_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

import '../repository/home_interface.dart';

class HomeUseCase {
  final repository = Modular.get<IHome>();
  final _preference = Modular.get<PreferenceUsecase>();
  ClientModel? _clientModel;
  List<DeviceModel>? _deviceModelList;
  String? getPersonName() {
    return _clientModel?.person?.name;
  }

  Future<String?> getClientFromRepository() async {
    try {
      String? token = await _preference.getAccessToken();
      if (token != null) {
        _clientModel = await repository.getClient(token);
      } else {
        return "session-error-tittle".i18n();
      }
      if (_clientModel != null) {
        return null;
      } else {
        return "error-get-client".i18n();
      }
    } on DioError {
      return "error-get-client".i18n();
    } catch (e) {
      return "error-get-client".i18n();
    }
  }

  Future<String?> getDevicesFromRepository() async {
    try {
      String? token = await _preference.getAccessToken();
      if (token != null) {
        _deviceModelList = await repository.getDevices(token);
      } else {
        return "session-error-tittle".i18n();
      }
      return null;
    } catch (e) {
      return "server-error".i18n();
    }
  }

  List<DeviceDTO>? getDevices() {
    return _deviceModelList?.map((device) {
      return DeviceDTO(id: device.id, name: device.name);
    }).toList();
  }

  Future<List<PlantStatsModel>?> getPlantList() async {
    return await repository.getPlantStats();
  }
}
