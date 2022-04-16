import 'dart:async';
import 'package:basearch/src/features/auth/domain/model/client.dart';
import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/presentation/view/page/password_recovery.dart';
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
  String name = '';

  @observable
  String lastName = '';

  @observable
  String password = '';

  @observable
  String clientName = '';

  @action
  updateEmail(String value) {
    email = value;
  }

  @action
  updatePassword(String value) {
    password = value;
  }

  void login() async {}

  String? emailValidation() {
    return _usecase.validateEmail(email);
  }

  String? passwordValidation() {
    return _usecase.validatePassword(password);
  }

  String? nameValidation() {
    return _usecase.validateName(name);
  }

  String? lastNameValidation() {
    return _usecase.validateLastName(lastName);
  }
}
