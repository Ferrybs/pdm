// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$personDTOAtom =
      Atom(name: '_HomeViewModelBase.personDTO', context: context);

  @override
  PersonDTO get personDTO {
    _$personDTOAtom.reportRead();
    return super.personDTO;
  }

  @override
  set personDTO(PersonDTO value) {
    _$personDTOAtom.reportWrite(value, super.personDTO, () {
      super.personDTO = value;
    });
  }

  late final _$devicelistAtom =
      Atom(name: '_HomeViewModelBase.devicelist', context: context);

  @override
  List<DeviceDTO> get devicelist {
    _$devicelistAtom.reportRead();
    return super.devicelist;
  }

  @override
  set devicelist(List<DeviceDTO> value) {
    _$devicelistAtom.reportWrite(value, super.devicelist, () {
      super.devicelist = value;
    });
  }

  late final _$chatbotSessionsAtom =
      Atom(name: '_HomeViewModelBase.chatbotSessions', context: context);

  @override
  List<ChatbotSessionDTO> get chatbotSessions {
    _$chatbotSessionsAtom.reportRead();
    return super.chatbotSessions;
  }

  @override
  set chatbotSessions(List<ChatbotSessionDTO> value) {
    _$chatbotSessionsAtom.reportWrite(value, super.chatbotSessions, () {
      super.chatbotSessions = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: '_HomeViewModelBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_HomeViewModelBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$plantListAtom =
      Atom(name: '_HomeViewModelBase.plantList', context: context);

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

  late final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase', context: context);

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
  void updateCurrentIndex(int idx) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updateCurrentIndex');
    try {
      return super.updateCurrentIndex(idx);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateError(String? value) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updateError');
    try {
      return super.updateError(value);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePlantList(List<PlantStatsModel> list) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updatePlantList');
    try {
      return super.updatePlantList(list);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDeviceList(List<DeviceDTO> list) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updateDeviceList');
    try {
      return super.updateDeviceList(list);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateChatbotSession(List<ChatbotSessionDTO> list) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updateChatbotSession');
    try {
      return super.updateChatbotSession(list);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
personDTO: ${personDTO},
devicelist: ${devicelist},
chatbotSessions: ${chatbotSessions},
currentIndex: ${currentIndex},
error: ${error},
plantList: ${plantList}
    ''';
  }
}
