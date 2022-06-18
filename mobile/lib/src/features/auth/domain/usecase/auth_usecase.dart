import 'dart:async';
import 'package:basearch/src/features/auth/data/dto/login_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/login_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:basearch/src/features/auth/domain/model/register_model.dart';
import 'package:basearch/src/features/auth/domain/model/token_data_model.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:basearch/src/validators/validator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../repository/auth_interface.dart';

class AuthUseCase {
  final _repository = Modular.get<IAuth>();
  final _preferences = Modular.get<PreferenceUsecase>();

  Future<bool> hasValidToken() async {
    if (await _preferences.getAccessToken() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> resetPassword(String? email) async {
    CredentialsModel? credentials;
    if (email != null) {
      credentials = CredentialsModel(email: email);
      try {
        if (await _repository.resetPassword(credentials)) {
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
      } catch (e) {
        return "server-error".i18n();
      }
    }
    return "server-error".i18n();
  }

  Future<String?> login(LoginDTO loginDTO, bool isRefreshToken) async {
    try {
      LoginModel loginModel = LoginModel(
          email: loginDTO.email?.trim() ?? '',
          password: loginDTO.password?.trim() ?? '');
      TokenDataModel tokenData = await _repository.login(loginModel);

      if (isRefreshToken) {
        TokenDataModel refreshToken =
            await _repository.getRefreshToken(tokenData.token);
        await _preferences.setRefreshToken(refreshToken.token);
      }
      await _preferences.setAccessToken(tokenData.token);
      return null;
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
    } catch (e) {
      return "server-error".i18n();
    }
  }

  Future<String?> register(LoginDTO loginDTO, PersonDTO personDTO) async {
    LoginModel loginModel = LoginModel(
        email: loginDTO.email?.trim() ?? '',
        password: loginDTO.password?.trim() ?? '');
    PersonModel personModel = PersonModel(
        name: personDTO.name?.trim() ?? '',
        lastName: personDTO.lastName?.trim() ?? "");
    RegisterModel registerModel =
        RegisterModel(login: loginModel, person: personModel);
    try {
      if (await _repository.register(registerModel)) {
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
