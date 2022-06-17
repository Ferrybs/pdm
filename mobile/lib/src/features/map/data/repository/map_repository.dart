import 'package:basearch/src/features/map/data/repository/map_repository_base.dart';
import 'package:basearch/src/features/map/domain/model/device_model.dart';
import 'package:basearch/src/features/map/domain/repository/map_interface.dart';
import 'package:dio/dio.dart';

class MapRepository extends MapRepositoryBase implements Imap {
  @override
  Future<List<DeviceModel>> getDevices(String token) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.get("/device",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return (response.data["deviceDTO"] as List)
          .map((e) => DeviceModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
