import 'dart:async';

import 'package:basearch/src/features/auth/data/repository/repository.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/response_model.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/login_interface.dart';

class LoginRepository extends Repository implements ILogin {
  final Dio dio = Dio();
  @override
  Future<ClientModel> login(CredentialsModel credentials) async {
    try {
      Response response;
      response = await dio.get(url);
      response.statusCode;
      throw UnimplementedError();
    } catch (e) {
      print(e);
    }
    throw UnimplementedError();
  }

  @override
  recoveryPassword(CredentialsModel credentials) {
    // TODO: implement recoveryPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> register(client) async {
    try {
      Response response;
      var dio = Dio(options);
      print(client.toJson());
      response = await dio.post("/auth/register", data: client.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        final recive = ResponseModel.fromJson(response.data);
        print(recive.toJson());
        if (recive.ok == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
