import 'dart:async';
import 'package:basearch/src/features/auth/data/dto/client_dto.dart';
import 'package:basearch/src/features/auth/data/dto/credentials_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:basearch/src/validators/validator.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../repository/login_interface.dart';

class LoginUseCase {
  final repository = Modular.get<ILogin>();

  Future<ClientModel> login(String email, String password) {
    return repository.login(CredentialsModel(email: email, password: password));
  }

  Future<bool> register(
      CredentialsDto credentialsDto, PersonDto personDto) async {
    var credetialsModel = CredentialsModel(
        email: credentialsDto.email, password: credentialsDto.password);
    var personModel =
        PersonModel(name: personDto.name, lastName: personDto.lastName);
    var clientModel =
        ClientModel(credentials: credetialsModel, person: personModel);
    return repository.register(clientModel);
  }

  String? passwordMatch(String? password, String? rPassword) {
    if (password != rPassword || password == '') {
      return 'invalid-passwordMatch'.i18n();
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || !email.isEmail()) {
      return 'invalid-email'.i18n();
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || !password.isPassword()) {
      return 'invalid-password'.i18n();
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || !name.isPerson()) {
      return 'invalid-name'.i18n();
    }
    return null;
  }

  String? validateLastName(String? lastName) {
    if (lastName == null || !lastName.isPerson()) {
      return 'invalid-last-name'.i18n();
    }
    return null;
  }
}
