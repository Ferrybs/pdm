import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';

abstract class ILogin {
  Future<ClientModel> login(Credentials credentials);
  Future<bool> register(ClientModel client);
  recoveryPassword(Credentials credentials);
}
