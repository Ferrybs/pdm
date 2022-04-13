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

  String? validateEmail(String? email) {
    if (email == null || !email.isEmail()) {
      return 'invalid-email'.i18n();
    }
    return null;
  }

  String? validatePassword(String? password) {
    print(password);
    print(password?.isPassword());
    if (password == null || !password.isPassword()) {
      return 'invalid-password'.i18n();
    }
    return null;
  }

  String? validateName(String? email) {
    if (email == null || !email.isPerson()) {
      return 'invalid-name'.i18n();
    }
    return null;
  }

  String? validateLastName(String? email) {
    if (email == null || !email.isPerson()) {
      return 'invalid-last-name'.i18n();
    }
    return null;
  }
}
