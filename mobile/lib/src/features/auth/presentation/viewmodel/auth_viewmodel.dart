import 'dart:async';
import 'package:basearch/src/features/auth/data/dto/login_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/auth_usecase.dart';

part 'auth_viewmodel.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  final _usecase = Modular.get<AuthUseCase>();

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

  Future<String?> resetPassword() async {
    return _usecase.resetPassword(email);
  }

  Future<String?> login() async {
    var loginDTO = LoginDTO(email, password);
    var result = await _usecase.login(loginDTO);
    if (result == null) {
      Modular.to.navigate("/home/");
    }
    return result;
  }

  Future<String?> register() async {
    var personDTO = PersonDTO(name, lastName);
    var loginDTO = LoginDTO(email, password);
    return _usecase.register(loginDTO, personDTO);
  }

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
    if (emailValidation() == null && password != '') {
      return true;
    }
    return false;
  }

  bool resetPasswordValidation() {
    if (emailValidation() == null) {
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

  void navigateTOLoginPage() {
    Modular.to.navigate("/auth/");
  }
}
