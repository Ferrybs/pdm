// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$nameAtom = Atom(name: '_HomeViewModelBase.name');

  @override
  String get userName {
    _$nameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$nameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
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

  @override
  String toString() {
    return '''
name: ${userName},
plantList: ${plantList}
    ''';
  }
}
