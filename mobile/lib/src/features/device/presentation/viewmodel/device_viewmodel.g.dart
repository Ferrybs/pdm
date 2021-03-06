// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeviceViewModel on _DeviceViewModel, Store {
  late final _$stepIndexAtom =
      Atom(name: '_DeviceViewModel.stepIndex', context: context);

  @override
  int get stepIndex {
    _$stepIndexAtom.reportRead();
    return super.stepIndex;
  }

  @override
  set stepIndex(int value) {
    _$stepIndexAtom.reportWrite(value, super.stepIndex, () {
      super.stepIndex = value;
    });
  }

  late final _$isDeviceConfigAtom =
      Atom(name: '_DeviceViewModel.isDeviceConfig', context: context);

  @override
  bool get isDeviceConfig {
    _$isDeviceConfigAtom.reportRead();
    return super.isDeviceConfig;
  }

  @override
  set isDeviceConfig(bool value) {
    _$isDeviceConfigAtom.reportWrite(value, super.isDeviceConfig, () {
      super.isDeviceConfig = value;
    });
  }

  late final _$deviceConfigStatusAtom =
      Atom(name: '_DeviceViewModel.deviceConfigStatus', context: context);

  @override
  StepState get deviceConfigStatus {
    _$deviceConfigStatusAtom.reportRead();
    return super.deviceConfigStatus;
  }

  @override
  set deviceConfigStatus(StepState value) {
    _$deviceConfigStatusAtom.reportWrite(value, super.deviceConfigStatus, () {
      super.deviceConfigStatus = value;
    });
  }

  late final _$wifiConfigStatusAtom =
      Atom(name: '_DeviceViewModel.wifiConfigStatus', context: context);

  @override
  StepState get wifiConfigStatus {
    _$wifiConfigStatusAtom.reportRead();
    return super.wifiConfigStatus;
  }

  @override
  set wifiConfigStatus(StepState value) {
    _$wifiConfigStatusAtom.reportWrite(value, super.wifiConfigStatus, () {
      super.wifiConfigStatus = value;
    });
  }

  late final _$finishConfigStatusAtom =
      Atom(name: '_DeviceViewModel.finishConfigStatus', context: context);

  @override
  StepState get finishConfigStatus {
    _$finishConfigStatusAtom.reportRead();
    return super.finishConfigStatus;
  }

  @override
  set finishConfigStatus(StepState value) {
    _$finishConfigStatusAtom.reportWrite(value, super.finishConfigStatus, () {
      super.finishConfigStatus = value;
    });
  }

  late final _$isWifiConfigAtom =
      Atom(name: '_DeviceViewModel.isWifiConfig', context: context);

  @override
  bool get isWifiConfig {
    _$isWifiConfigAtom.reportRead();
    return super.isWifiConfig;
  }

  @override
  set isWifiConfig(bool value) {
    _$isWifiConfigAtom.reportWrite(value, super.isWifiConfig, () {
      super.isWifiConfig = value;
    });
  }

  late final _$isFinishConfigAtom =
      Atom(name: '_DeviceViewModel.isFinishConfig', context: context);

  @override
  bool get isFinishConfig {
    _$isFinishConfigAtom.reportRead();
    return super.isFinishConfig;
  }

  @override
  set isFinishConfig(bool value) {
    _$isFinishConfigAtom.reportWrite(value, super.isFinishConfig, () {
      super.isFinishConfig = value;
    });
  }

  late final _$deviceNameAtom =
      Atom(name: '_DeviceViewModel.deviceName', context: context);

  @override
  String? get deviceName {
    _$deviceNameAtom.reportRead();
    return super.deviceName;
  }

  @override
  set deviceName(String? value) {
    _$deviceNameAtom.reportWrite(value, super.deviceName, () {
      super.deviceName = value;
    });
  }

  late final _$loadErrorAtom =
      Atom(name: '_DeviceViewModel.loadError', context: context);

  @override
  String? get loadError {
    _$loadErrorAtom.reportRead();
    return super.loadError;
  }

  @override
  set loadError(String? value) {
    _$loadErrorAtom.reportWrite(value, super.loadError, () {
      super.loadError = value;
    });
  }

  late final _$errorDeviceNameAtom =
      Atom(name: '_DeviceViewModel.errorDeviceName', context: context);

  @override
  String? get errorDeviceName {
    _$errorDeviceNameAtom.reportRead();
    return super.errorDeviceName;
  }

  @override
  set errorDeviceName(String? value) {
    _$errorDeviceNameAtom.reportWrite(value, super.errorDeviceName, () {
      super.errorDeviceName = value;
    });
  }

  late final _$errorWifiAtom =
      Atom(name: '_DeviceViewModel.errorWifi', context: context);

  @override
  String? get errorWifi {
    _$errorWifiAtom.reportRead();
    return super.errorWifi;
  }

  @override
  set errorWifi(String? value) {
    _$errorWifiAtom.reportWrite(value, super.errorWifi, () {
      super.errorWifi = value;
    });
  }

  late final _$wifiDTOAtom =
      Atom(name: '_DeviceViewModel.wifiDTO', context: context);

  @override
  WifiDTO get wifiDTO {
    _$wifiDTOAtom.reportRead();
    return super.wifiDTO;
  }

  @override
  set wifiDTO(WifiDTO value) {
    _$wifiDTOAtom.reportWrite(value, super.wifiDTO, () {
      super.wifiDTO = value;
    });
  }

  late final _$mqttDTOAtom =
      Atom(name: '_DeviceViewModel.mqttDTO', context: context);

  @override
  MqttDTO get mqttDTO {
    _$mqttDTOAtom.reportRead();
    return super.mqttDTO;
  }

  @override
  set mqttDTO(MqttDTO value) {
    _$mqttDTOAtom.reportWrite(value, super.mqttDTO, () {
      super.mqttDTO = value;
    });
  }

  late final _$_DeviceViewModelActionController =
      ActionController(name: '_DeviceViewModel', context: context);

  @override
  dynamic updateDeviceName(String? value) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.updateDeviceName');
    try {
      return super.updateDeviceName(value);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateErrorDeviceName(String? value) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.updateErrorDeviceName');
    try {
      return super.updateErrorDeviceName(value);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateErrorWifi(String? value) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.updateErrorWifi');
    try {
      return super.updateErrorWifi(value);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateSSID(String? value) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.updateSSID');
    try {
      return super.updateSSID(value);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updatePassword(String? value) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.updatePassword');
    try {
      return super.updatePassword(value);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDeviceConfig() {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.changeDeviceConfig');
    try {
      return super.changeDeviceConfig();
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeFinishConfigStatus(StepState status) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.changeFinishConfigStatus');
    try {
      return super.changeFinishConfigStatus(status);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDeviceConfigStatus(StepState status) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.changeDeviceConfigStatus');
    try {
      return super.changeDeviceConfigStatus(status);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeWifiConfigStatus(StepState status) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.changeWifiConfigStatus');
    try {
      return super.changeWifiConfigStatus(status);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStep(int step) {
    final _$actionInfo = _$_DeviceViewModelActionController.startAction(
        name: '_DeviceViewModel.setStep');
    try {
      return super.setStep(step);
    } finally {
      _$_DeviceViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stepIndex: ${stepIndex},
isDeviceConfig: ${isDeviceConfig},
deviceConfigStatus: ${deviceConfigStatus},
wifiConfigStatus: ${wifiConfigStatus},
finishConfigStatus: ${finishConfigStatus},
isWifiConfig: ${isWifiConfig},
isFinishConfig: ${isFinishConfig},
deviceName: ${deviceName},
loadError: ${loadError},
errorDeviceName: ${errorDeviceName},
errorWifi: ${errorWifi},
wifiDTO: ${wifiDTO},
mqttDTO: ${mqttDTO}
    ''';
  }
}
