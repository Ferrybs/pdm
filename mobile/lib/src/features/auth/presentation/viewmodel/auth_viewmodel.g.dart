// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthViewModel on _AuthViewModelBase, Store {
  final _$nameAtom = Atom(name: '_AuthViewModelBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$lastNameAtom = Atom(name: '_AuthViewModelBase.lastName');

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  final _$emailAtom = Atom(name: '_AuthViewModelBase.email');

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

  final _$passwordAtom = Atom(name: '_AuthViewModelBase.password');

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

  final _$confirmPasswordAtom =
      Atom(name: '_AuthViewModelBase.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$_AuthViewModelBaseActionController =
      ActionController(name: '_AuthViewModelBase');

  @override
  dynamic updateName(String value) {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.updateName');
    try {
      return super.updateName(value);
    } finally {
      _$_AuthViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateLastName(String value) {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.updateLastName');
    try {
      return super.updateLastName(value);
    } finally {
      _$_AuthViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateEmail(String value) {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.updateEmail');
    try {
      return super.updateEmail(value);
    } finally {
      _$_AuthViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updatePassword(String value) {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.updatePassword');
    try {
      return super.updatePassword(value);
    } finally {
      _$_AuthViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateConfirmPassword(String value) {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.updateConfirmPassword');
    try {
      return super.updateConfirmPassword(value);
    } finally {
      _$_AuthViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
lastName: ${lastName},
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword}
    ''';
  }
}