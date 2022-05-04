import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:basearch/src/features/home/domain/model/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repository/home_interface.dart';

class HomeUseCase {
  final repository = Modular.get<IHome>();

  Future<String> getUserName() async {
    UserModel? userModel = await repository.getUsuario();
    return userModel != null ? userModel.name : "";
  }

  Future<List<PlantStatsModel>> getPlantList() async {
    List<PlantStatsModel>? plantList = await repository.getPlantStats();
    return plantList ?? [];
  }
}
