// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$clientNameAtom = Atom(name: '_HomeViewModelBase.clientName');

  @override
  String? get clientName {
    _$clientNameAtom.reportRead();
    return super.clientName;
  }

  @override
  set clientName(String? value) {
    _$clientNameAtom.reportWrite(value, super.clientName, () {
      super.clientName = value;
    });
  }

  final _$plantListAtom = Atom(name: '_HomeViewModelBase.plantList');

  @override
  List<PlantStatsModel> get plantList {
    _$plantListAtom.reportRead();
    return super.plantList;
  }

  @override
  set plantList(List<PlantStatsModel> value) {
    _$plantListAtom.reportWrite(value, super.plantList, () {
      super.plantList = value;
    });
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  void updateClientName(String name) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updateClientName');
    try {
      return super.updateClientName(name);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clientName: ${clientName},
plantList: ${plantList}
    ''';
  }
}
