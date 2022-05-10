import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repository/home_interface.dart';

class HomeUseCase {
  final repository = Modular.get<IHome>();

  Future<String> getUserName() async {
    ClientModel? clientModel = await repository.getClient();
    return clientModel?.person?.name ?? "";
  }

  Future<List<PlantStatsModel>> getPlantList() async {
    List<PlantStatsModel>? plantList = await repository.getPlantStats();
    return plantList ?? [];
  }
}
