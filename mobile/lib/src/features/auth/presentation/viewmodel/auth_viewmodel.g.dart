// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthViewModel on _AuthViewModelBase, Store {
  late final _$nameAtom =
      Atom(name: '_AuthViewModelBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_AuthViewModelBase.lastName', context: context);

  @override
  String? get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String? value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_AuthViewModelBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_AuthViewModelBase.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_AuthViewModelBase.confirmPassword', context: context);

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$hasTokenAtom =
      Atom(name: '_AuthViewModelBase.hasToken', context: context);

  @override
  bool get hasToken {
    _$hasTokenAtom.reportRead();
    return super.hasToken;
  }

  @override
  set hasToken(bool value) {
    _$hasTokenAtom.reportWrite(value, super.hasToken, () {
      super.hasToken = value;
    });
  }

  late final _$isRefreshTokenAtom =
      Atom(name: '_AuthViewModelBase.isRefreshToken', context: context);

  @override
  bool get isRefreshToken {
    _$isRefreshTokenAtom.reportRead();
    return super.isRefreshToken;
  }

  @override
  set isRefreshToken(bool value) {
    _$isRefreshTokenAtom.reportWrite(value, super.isRefreshToken, () {
      super.isRefreshToken = value;
    });
  }

  late final _$_AuthViewModelBaseActionController =
      ActionController(name: '_AuthViewModelBase', context: context);

  @override
  dynamic changeRefresh(bool? value) {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.changeRefresh');
    try {
      return super.changeRefresh(value);
    } finally {
      _$_AuthViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic updateToken(bool value) {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.updateToken');
    try {
      return super.updateToken(value);
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
confirmPassword: ${confirmPassword},
hasToken: ${hasToken},
isRefreshToken: ${isRefreshToken}
    ''';
  }
}
