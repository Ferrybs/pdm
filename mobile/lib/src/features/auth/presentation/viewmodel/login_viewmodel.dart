import 'dart:async';
import 'dart:ffi';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/credentials_model.dart';
import 'package:basearch/src/features/auth/presentation/view/page/reset_password.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/login_usecase.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  final _usecase = Modular.get<LoginUseCase>();

  @observable
  String name = '';

  @observable
  String lastName = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @action
  updateName(String value) {
    name = value;
  }

  @action
  updateLastName(String value) {
    lastName = value;
  }

  @action
  updateEmail(String value) {
    email = value;
  }

  @action
  updatePassword(String value) {
    password = value;
  }

  @action
  updateConfirmPassword(String value) {
    confirmPassword = value;
  }

  void register() async {}

  String? nameValidation() {
    return _usecase.validateName(name);
  }

  String? lastNameValidation() {
    return _usecase.validateLastName(lastName);
  }

  String? emailValidation() {
    return _usecase.validateEmail(email);
  }

  String? passwordValidation() {
    return _usecase.validatePassword(password);
  }

  String? passwordMatchValidation() {
    return _usecase.passwordMatch(password, confirmPassword);
  }

  bool signInValidation() {
    if (emailValidation() == null &&
        passwordValidation() == null &&
        passwordMatchValidation() == null) {
      return true;
    }
    return false;
  }

  bool signUpValidation() {
    if (nameValidation() == null &&
        lastNameValidation() == null &&
        emailValidation() == null &&
        passwordValidation() == null &&
        passwordMatchValidation() == null) {
      return true;
    }
    return false;
  }
}
