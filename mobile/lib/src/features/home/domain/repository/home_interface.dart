import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';

import '../model/user_model.dart';

abstract class IHome {
  Future<List<PlantStatsModel>?> getPlantStats();
  Future<UserModel?> getUsuario();
}
