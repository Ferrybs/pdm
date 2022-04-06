import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/client.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repository/login_interface.dart';

class LoginUseCase {
  final repository = Modular.get<ILogin>();

  FutureOr<Client> login(String email, String password) {
    return repository.login(Credentials(email, password));
  }
}
