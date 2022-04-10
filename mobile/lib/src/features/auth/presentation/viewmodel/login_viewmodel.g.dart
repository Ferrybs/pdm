// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  final _$emailAtom = Atom(name: '_LoginViewModelBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginViewModelBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$clientNameAtom = Atom(name: '_LoginViewModelBase.clientName');

  @override
  String get clientName {
    _$clientNameAtom.reportRead();
    return super.clientName;
  }

  @override
  set clientName(String value) {
    _$clientNameAtom.reportWrite(value, super.clientName, () {
      super.clientName = value;
    });
  }

  final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase');

  @override
  dynamic updateEmail(String value) {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.updateEmail');
    try {
      return super.updateEmail(value);
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updatePassword(String value) {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.updatePassword');
    try {
      return super.updatePassword(value);
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
clientName: ${clientName}
    ''';
  }
}
