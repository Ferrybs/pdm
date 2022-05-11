import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';

abstract class IHome {
  Future<List<PlantStatsModel>?> getPlantStats();
  Future<ClientModel?> getClient();
}
