import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/client.dart';

abstract class ILogin {
  Future<Client> login(Credentials credentials);
  Future<Client> register(Client client);
  recoveryPassword(Credentials credentials);
}
