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
  Future<List<PlantStatsModel>?> getPlantStats() {
    Future<List<PlantStatsModel>?> list = Future.value(
      [
        PlantStatsModel(
          name: "planta #1",
          temperature: 32,
          luminosity: 34,
          moisture: 23,
          waterTank: 32,
          temperatureChart: [
            ChartSerie(time: 1, value: 14),
            ChartSerie(time: 2, value: 23),
            ChartSerie(time: 3, value: 45),
            ChartSerie(time: 4, value: 34),
            ChartSerie(time: 5, value: 63),
            ChartSerie(time: 6, value: 23),
            ChartSerie(time: 7, value: 76),
            ChartSerie(time: 8, value: 23),
            ChartSerie(time: 9, value: 52),
            ChartSerie(time: 10, value: 32),
          ],
          luminosityChart: [
            ChartSerie(time: 1, value: 42),
            ChartSerie(time: 2, value: 53),
            ChartSerie(time: 3, value: 34),
            ChartSerie(time: 4, value: 23),
            ChartSerie(time: 5, value: 53),
            ChartSerie(time: 6, value: 23),
            ChartSerie(time: 7, value: 76),
            ChartSerie(time: 8, value: 47),
            ChartSerie(time: 9, value: 23),
            ChartSerie(time: 10, value: 34),
          ],
          moistureChart: [
            ChartSerie(time: 1, value: 23),
            ChartSerie(time: 2, value: 24),
            ChartSerie(time: 3, value: 63),
            ChartSerie(time: 4, value: 23),
            ChartSerie(time: 5, value: 45),
            ChartSerie(time: 6, value: 72),
            ChartSerie(time: 7, value: 43),
            ChartSerie(time: 8, value: 62),
            ChartSerie(time: 9, value: 46),
            ChartSerie(time: 10, value: 23),
          ],
        ),
        PlantStatsModel(
          name: "planta #2",
          temperature: 23,
          luminosity: 42,
          moisture: 44,
          waterTank: 52,
          temperatureChart: [
            ChartSerie(time: 1, value: 53),
            ChartSerie(time: 2, value: 23),
            ChartSerie(time: 3, value: 43),
            ChartSerie(time: 4, value: 43),
            ChartSerie(time: 5, value: 12),
            ChartSerie(time: 6, value: 25),
            ChartSerie(time: 7, value: 25),
            ChartSerie(time: 8, value: 43),
            ChartSerie(time: 9, value: 53),
            ChartSerie(time: 10, value: 23),
          ],
          luminosityChart: [
            ChartSerie(time: 1, value: 23),
            ChartSerie(time: 2, value: 34),
            ChartSerie(time: 3, value: 23),
            ChartSerie(time: 4, value: 54),
            ChartSerie(time: 5, value: 62),
            ChartSerie(time: 6, value: 32),
            ChartSerie(time: 7, value: 52),
            ChartSerie(time: 8, value: 34),
            ChartSerie(time: 9, value: 52),
            ChartSerie(time: 10, value: 42),
          ],
          moistureChart: [
            ChartSerie(time: 1, value: 45),
            ChartSerie(time: 2, value: 34),
            ChartSerie(time: 3, value: 26),
            ChartSerie(time: 4, value: 36),
            ChartSerie(time: 5, value: 52),
            ChartSerie(time: 6, value: 36),
            ChartSerie(time: 7, value: 45),
            ChartSerie(time: 8, value: 25),
            ChartSerie(time: 9, value: 42),
            ChartSerie(time: 10, value: 44),
          ],
        ),
        PlantStatsModel(
          name: "planta #3",
          temperature: 42,
          luminosity: 43,
          moisture: 52,
          waterTank: 14,
          temperatureChart: [
            ChartSerie(time: 1, value: 23),
            ChartSerie(time: 2, value: 45),
            ChartSerie(time: 3, value: 23),
            ChartSerie(time: 4, value: 44),
            ChartSerie(time: 5, value: 42),
            ChartSerie(time: 6, value: 36),
            ChartSerie(time: 7, value: 73),
            ChartSerie(time: 8, value: 53),
            ChartSerie(time: 9, value: 42),
            ChartSerie(time: 10, value: 42),
          ],
          luminosityChart: [
            ChartSerie(time: 1, value: 52),
            ChartSerie(time: 2, value: 34),
            ChartSerie(time: 3, value: 63),
            ChartSerie(time: 4, value: 42),
            ChartSerie(time: 5, value: 74),
            ChartSerie(time: 6, value: 34),
            ChartSerie(time: 7, value: 74),
            ChartSerie(time: 8, value: 83),
            ChartSerie(time: 9, value: 53),
            ChartSerie(time: 10, value: 43),
          ],
          moistureChart: [
            ChartSerie(time: 1, value: 53),
            ChartSerie(time: 2, value: 36),
            ChartSerie(time: 3, value: 42),
            ChartSerie(time: 4, value: 62),
            ChartSerie(time: 5, value: 51),
            ChartSerie(time: 6, value: 23),
            ChartSerie(time: 7, value: 42),
            ChartSerie(time: 8, value: 52),
            ChartSerie(time: 9, value: 23),
            ChartSerie(time: 10, value: 52),
          ],
        ),
        PlantStatsModel(
          name: "planta #4",
          temperature: 63,
          luminosity: 73,
          moisture: 42,
          waterTank: 62,
          temperatureChart: [
            ChartSerie(time: 1, value: 42),
            ChartSerie(time: 2, value: 36),
            ChartSerie(time: 3, value: 24),
            ChartSerie(time: 4, value: 72),
            ChartSerie(time: 5, value: 52),
            ChartSerie(time: 6, value: 34),
            ChartSerie(time: 7, value: 56),
            ChartSerie(time: 8, value: 42),
            ChartSerie(time: 9, value: 65),
            ChartSerie(time: 10, value: 63),
          ],
          luminosityChart: [
            ChartSerie(time: 1, value: 26),
            ChartSerie(time: 2, value: 83),
            ChartSerie(time: 3, value: 63),
            ChartSerie(time: 4, value: 56),
            ChartSerie(time: 5, value: 45),
            ChartSerie(time: 6, value: 34),
            ChartSerie(time: 7, value: 24),
            ChartSerie(time: 8, value: 45),
            ChartSerie(time: 9, value: 35),
            ChartSerie(time: 10, value: 73),
          ],
          moistureChart: [
            ChartSerie(time: 1, value: 45),
            ChartSerie(time: 2, value: 36),
            ChartSerie(time: 3, value: 42),
            ChartSerie(time: 4, value: 63),
            ChartSerie(time: 5, value: 54),
            ChartSerie(time: 6, value: 62),
            ChartSerie(time: 7, value: 48),
            ChartSerie(time: 8, value: 37),
            ChartSerie(time: 9, value: 57),
            ChartSerie(time: 10, value: 42),
          ],
        ),
      ],
    );
    return list;
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
