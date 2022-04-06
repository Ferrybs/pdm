import 'dart:async';
import 'dart:ffi';

import 'package:basearch/src/features/auth/domain/model/client.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/login_usecase.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final _usecase = Modular.get<LoginUseCase>();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String clientName = 'FHFHEHE';

  @action
  updateEmail(String value) {
    email = value;
  }

  @action
  updatePassword(String value) {
    password = value;
  }

  Future<Client?> login() async {
    //TODO: Validate username
    //TODO: Validate password
    try {
      var client = await _usecase.login(email, password);
      clientName = client.person.name;
      //await Future.delayed(Duration(seconds: 2));
      return client;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
