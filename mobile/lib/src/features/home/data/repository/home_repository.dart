import 'dart:async';

import 'package:basearch/src/features/home/data/repository/home_repository_base.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:basearch/src/features/home/domain/model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
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
  Future<ClientModel?> getClient() async {
    try {
      EncryptedSharedPreferences encrypt = EncryptedSharedPreferences();
      String? token = await encrypt.getString("AccessToken");
      Response response;
      var dio = Dio(APIoptions);
      response = await dio.get("/client/",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      if (response.statusCode == 200) {
        final data = ResponseModel.fromJson(response.data);
        if (data.ok == true) {
          return ClientModel.fromJson(response.data["clientDTO"]);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
