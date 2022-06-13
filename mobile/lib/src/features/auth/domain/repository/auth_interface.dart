import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/login_model.dart';
import 'package:basearch/src/features/auth/domain/model/register_model.dart';
import 'package:basearch/src/features/auth/domain/model/token_data_model.dart';

abstract class IAuth {
  Future<TokenDataModel> login(LoginModel loginModel);
  Future<bool> register(RegisterModel registerModel);
  Future<bool> resetPassword(CredentialsModel credentials);
  Future<TokenDataModel> getRefreshToken(String token);
}
