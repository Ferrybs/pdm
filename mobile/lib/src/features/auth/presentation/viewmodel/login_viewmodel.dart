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
  late Client client;

  @action
  updateClient(Client client) {
    client = client;
  }

  @action
  updateEmail(String value) {
    email = value;
  }

  @action
  updatePassword(String value) {
    password = value;
  }

  FutureOr<Client?> login() async {
    //TODO: Validate username
    //TODO: Validate password
    try {
      //await Future.delayed(Duration(seconds: 2));
      return await _usecase.login(email, password);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
