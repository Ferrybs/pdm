import 'dart:async';
import 'package:basearch/src/features/auth/data/dto/client_dto.dart';
import 'package:basearch/src/features/auth/data/dto/credentials_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/login_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:basearch/src/validators/validator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../repository/login_interface.dart';

class LoginUseCase {
  final repository = Modular.get<ILogin>();
  ClientModel? _client;

  ClientModel? get() {
    return _client;
  }

  void set(ClientModel? client) {
    _client = client;
  }

  Future<bool> resetPassword(String email) async {
    var credentials = CredentialsModel(email: email);
    return await repository.resetPassword(credentials);
  }

  Future<String?> login(String email, String password) async {
    try {
      LoginModel? loginModel = await repository
          .login(CredentialsModel(email: email, password: password));
      if (loginModel != null && loginModel.client != null) {
        set(loginModel.client);
      }
      if (_client != null) {
        return null;
      } else {
        final requestOptions = RequestOptions(path: "/auth/login");
        throw DioError(requestOptions: requestOptions);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400:
            return "invalid-field".i18n();
          case 401:
            return "not-found".i18n();
          default:
            if (e.response?.data) {
              var data = e.response?.data;
              if (data["message"] != null) {
                return data["message"];
              }
            }
        }
      }
      return "server-error".i18n();
    }
  }

  Future<String?> register(
      CredentialsDto credentialsDto, PersonDto personDto) async {
    var credetialsModel = CredentialsModel(
        email: credentialsDto.email, password: credentialsDto.password);
    var personModel =
        PersonModel(name: personDto.name, lastName: personDto.lastName);
    var clientModel =
        ClientModel(credentials: credetialsModel, person: personModel);
    try {
      if (await repository.register(clientModel)) {
        return null;
      } else {
        final requestOptions = RequestOptions(path: "/auth/register");
        throw DioError(requestOptions: requestOptions);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 403:
            return "user-registered".i18n();
          case 400:
            return "invalid-field".i18n();
          default:
            if (e.response?.data) {
              var data = e.response?.data;
              if (data["message"] != null) {
                return data["message"];
              }
            }
        }
      }
      return "server-error".i18n();
    }
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
