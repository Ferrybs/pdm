import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/login_model.dart';

abstract class ILogin {
  Future<LoginModel?> login(CredentialsModel credentials);
  Future<bool> register(ClientModel client);
  Future<bool> resetPassword(CredentialsModel credentials);
}
