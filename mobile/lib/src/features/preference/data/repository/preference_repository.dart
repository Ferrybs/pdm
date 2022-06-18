import 'package:basearch/src/features/preference/data/repository/preference_repository_base.dart';
import 'package:basearch/src/features/preference/domain/model/token_data_model.dart';
import 'package:basearch/src/features/preference/domain/repository/preference_interface.dart';
import 'package:dio/dio.dart';

class PreferenceRepository extends PreferenceRepositoryBase
    implements IPreference {
  @override
  Future<TokenDataModel?> getAccessToken(String refreshToken) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.get("/auth/access-token",
          options:
              Options(headers: {"Authorization": "Bearer " + refreshToken}));
      if (response.statusCode == 200) {
        var token = TokenDataModel.fromJson(response.data['tokenData']);
        return token;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isValidAccessToken(String token) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.get("/auth/sessions/",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
