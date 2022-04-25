import 'dart:async';

import 'package:basearch/src/features/auth/data/repository/repository.dart';
import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/person.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/login_interface.dart';

class LoginRepository extends Repository implements ILogin {
  final String url = "https://api-pdm-pia3.herokuapp.com/";
  final Dio dio = Dio();
  @override
  Future<ClientModel> login(Credentials credentials) async {
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
  recoveryPassword(Credentials credentials) {
    // TODO: implement recoveryPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> register(client) {
    var dio = Dio(options);

    throw UnimplementedError();
  }
}
