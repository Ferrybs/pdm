import 'dart:async';

import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/person.dart';
import 'package:basearch/src/features/auth/domain/model/client.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/login_interface.dart';

class LoginRepository implements ILogin {
  @override
  Future<Client> login(Credentials credentials) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('https://api-pdm-pia3.herokuapp.com/');
      print(response);
      return Client("", Credentials(" ", " "), Person("Felipe", ""));
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
  Future<Client> register(client) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
