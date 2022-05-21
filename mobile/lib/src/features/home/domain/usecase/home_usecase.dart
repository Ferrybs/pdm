import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

import '../repository/home_interface.dart';

class HomeUseCase {
  final repository = Modular.get<IHome>();
  final encryptedPreferences = Modular.get<EncryptedSharedPreferences>();
  ClientModel? _clientModel;

  String? getUserName() {
    return _clientModel?.person?.name;
  }

  Future<String?> getClient() async {
    try {
      String token = await encryptedPreferences.getString("AccessToken");
      _clientModel = await repository.getClient(token);
      if (_clientModel != null) {
        return null;
      } else {
        return "error-home-tittle".i18n();
      }
    } on DioError {
      return "error-home-tittle".i18n();
    }
  }

  Future<List<PlantStatsModel>?> getPlantList() async {
    return await repository.getPlantStats();
  }
}
