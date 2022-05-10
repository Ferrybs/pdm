import 'dart:async';

import 'package:basearch/src/features/home/data/repository/home_repository_base.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:dio/dio.dart';
import '../../domain/model/chart_serie.dart';
import '../../domain/repository/home_interface.dart';

class HomeRepository extends HomeRepositoryBase implements IHome {
  @override
  Future<List<PlantStatsModel>> getPlantStats() {
    return [
      PlantStatsModel(
        "planta 1",
        32,
        34,
        23,
        32,
        [
          ChartSerie(time: 1, value: 4),
          ChartSerie(time: 2, value: 3),
          ChartSerie(time: 3, value: 7)
        ],
        [ChartSerie(time: 1, value: 4)],
        [ChartSerie(time: 1, value: 4)],
      )
    ] as Future<List<PlantStatsModel>>;
  }

  @override
  Future<ClientModel> getClient() async {
    Response response;
    var dio = Dio(APIoptions);
    response = await dio.post("/auth/login", data: credentials.toJson());
    throw Error();
  }
}
