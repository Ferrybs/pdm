import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/token_data_model.dart';

abstract class IAuth {
  Future<TokenDataModel?> login(CredentialsModel credentials);
  Future<bool> register(ClientModel client);
  Future<bool> resetPassword(CredentialsModel credentials);
}
