import 'dart:async';
import 'package:basearch/src/features/auth/data/dto/login_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';
import 'package:basearch/src/features/auth/data/dto/register_dto.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/login_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:basearch/src/features/auth/domain/model/register_model.dart';
import 'package:basearch/src/features/auth/domain/model/token_data_model.dart';
import 'package:basearch/src/validators/validator.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../repository/auth_interface.dart';

class AuthUseCase {
  final repository = Modular.get<IAuth>();
  final _encryptedPreferences = Modular.get<EncryptedSharedPreferences>();

  setAccessToken(TokenDataModel? tokeData) async {
    String? token = tokeData?.token;
    if (token != null) {
      await _encryptedPreferences.setString("AccessToken", token);
    }
  }

  Future<String?> resetPassword(String email) async {
    var credentials = CredentialsModel(email: email);
    try {
      if (await repository.resetPassword(credentials)) {
        return null;
      } else {
        final requestOptions = RequestOptions(path: "/auth/reset-password");
        throw DioError(requestOptions: requestOptions);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 401:
            return "not-found".i18n();
          case 404:
            return "server-error".i18n();
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

  Future<String?> login(LoginDTO loginDTO) async {
    try {
      var loginModel =
          LoginModel(email: loginDTO.email, password: loginDTO.password);
      TokenDataModel? tokenData = await repository.login(loginModel);
      if (tokenData?.token != null) {
        await setAccessToken(tokenData);
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
          case 404:
            return "server-error".i18n();
          default:
            if (e.response?.data != null) {
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

  Future<String?> register(LoginDTO loginDTO, PersonDTO personDTO) async {
    var loginModel =
        LoginModel(email: loginDTO.email, password: loginDTO.password);
    var personModel =
        PersonModel(name: personDTO.name, lastName: personDTO.lastName);
    var registerModel = RegisterModel(login: loginModel, person: personModel);
    try {
      if (await repository.register(registerModel)) {
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
