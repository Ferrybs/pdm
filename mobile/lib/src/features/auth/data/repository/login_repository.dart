import 'dart:async';

import 'package:basearch/src/features/auth/data/repository/repository.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/login_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';
import 'package:basearch/src/features/auth/domain/model/response_model.dart';
import 'package:basearch/src/features/auth/domain/model/token_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../../domain/repository/login_interface.dart';

class LoginRepository extends Repository implements ILogin {
  @override
  Future<LoginModel?> login(CredentialsModel credentials) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.post("/auth/login", data: credentials.toJson());
      if (response.statusCode == 200) {
        final data = ResponseModel.fromJson(response.data);
        if (data.ok == true) {
          return LoginModel.fromJson(response.data);
        }
      }
      return null;
    } catch (e) {
      return null;
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
      return false;
    }
  }

  @override
  Future<bool> resetPassword(CredentialsModel credentials) async {
    try {
      print(credentials.toJson());
      Response response;
      var dio = Dio(options);
      response =
          await dio.post("/auth/reset-password", data: credentials.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        final recive = ResponseModel.fromJson(response.data);
        if (recive.ok == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
