import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/client.dart';

abstract class ILogin {
  FutureOr<Client> login(Credentials credentials);
  FutureOr<Client> register(Client client);
  recoveryPassword(Credentials credentials);
}
