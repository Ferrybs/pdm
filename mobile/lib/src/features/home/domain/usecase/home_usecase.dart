import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repository/home_interface.dart';

class HomeUseCase {
  final repository = Modular.get<IHome>();
  ClientModel? _clientModel;

  Future<String?> getUserName() async {
    try {
      _clientModel = await repository.getClient();
      return _clientModel?.person?.name;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<PlantStatsModel>> getPlantList() async {
    List<PlantStatsModel>? plantList = await repository.getPlantStats();
    return plantList ?? [];
  }
}
