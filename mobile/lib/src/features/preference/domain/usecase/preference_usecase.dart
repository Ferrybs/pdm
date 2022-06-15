import 'package:basearch/src/features/preference/data/repository/preference_repository.dart';
import 'package:basearch/src/features/preference/domain/model/token_data_model.dart';
import 'package:basearch/src/features/preference/domain/repository/preference_interface.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class PreferenceUsecase {
  final IPreference _repository = PreferenceRepository();
  final EncryptedSharedPreferences _encryptedSharedPreferences =
      EncryptedSharedPreferences();
  setAccessToken(String token) async {
    await _encryptedSharedPreferences.setString("access-token", token);
  }

  setRefreshToken(String token) async {
    await _encryptedSharedPreferences.setString("refresh-token", token);
  }

  logout() async {
    await _encryptedSharedPreferences.clear();
  }

  Future<String?> getAccessToken() async {
    String accessToken =
        await _encryptedSharedPreferences.getString("access-token");
    if (accessToken.length > 2) {
      if (await _repository.isValidAccessToken(accessToken)) {
        return accessToken;
      }
    }
    String refreshToken =
        await _encryptedSharedPreferences.getString("refresh-token");
    if (refreshToken.length > 2) {
      TokenDataModel? tokenModel =
          await _repository.getAccessToken(refreshToken);
      if (tokenModel != null) {
        setAccessToken(tokenModel.token);
        return tokenModel.token;
      }
    }

    return null;
  }
}
