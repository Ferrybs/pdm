import 'dart:async';
import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/client.dart';
import 'package:basearch/src/validators/validator.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../repository/login_interface.dart';

class LoginUseCase {
  final repository = Modular.get<ILogin>();

  Future<Client> login(String email, String password) {
    return repository.login(Credentials(email, password));
  }

  String? getErrorMessage(String email) {
    if (!email.isEmail()) {
      return 'invalid-email'.i18n();
    }
    return null;
  }
}
