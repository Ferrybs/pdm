import 'dart:async';

import 'package:basearch/src/features/auth/data/repository/repository.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/login_model.dart';
import 'package:basearch/src/features/auth/domain/model/response_model.dart';
import 'package:basearch/src/features/auth/domain/model/token_data_model.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/auth_interface.dart';

class AuthRepository extends AtuhRepositoryBase implements IAuth {
  @override
  Future<TokenDataModel?> login(LoginModel loginModel) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.post("/auth/login", data: loginModel.toJson());
      if (response.statusCode == 200) {
        final data = ResponseModel.fromJson(response.data);
        if (data.ok == true) {
          var token = TokenDataModel.fromJson(response.data['tokenData']);
          return token;
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> register(client) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.post("/auth/register", data: client.toJson());
      if (response.statusCode == 200) {
        final recive = ResponseModel.fromJson(response.data);
        if (recive.ok == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> resetPassword(CredentialsModel credentials) async {
    try {
      Response response;
      var dio = Dio(options);
      response =
          await dio.post("/auth/reset-password", data: credentials.toJson());
      if (response.statusCode == 200) {
        final recive = ResponseModel.fromJson(response.data);
        if (recive.ok == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
