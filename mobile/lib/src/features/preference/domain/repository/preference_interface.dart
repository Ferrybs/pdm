import 'package:basearch/src/features/preference/domain/model/token_data_model.dart';

abstract class IPreference {
  Future<TokenDataModel?> getAccessToken(String refreshToken);
  Future<bool> isValidAccessToken(String token);
}
