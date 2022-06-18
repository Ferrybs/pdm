import 'package:basearch/src/features/device/data/dto/mqtt_dto.dart';
import 'package:basearch/src/features/device/data/dto/wifi_dto.dart';
import 'package:basearch/src/features/device/domain/usecase/device_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'device_viewmodel.g.dart';

class DeviceViewModel = _DeviceViewModel with _$DeviceViewModel;

abstract class _DeviceViewModel with Store {
  final _usecase = Modular.get<DeviceUseCase>();

  @observable
  int stepIndex = 0;

  @observable
  bool isDeviceConfig = true;

  @observable
  StepState deviceConfigStatus = StepState.indexed;

  @observable
  StepState wifiConfigStatus = StepState.indexed;

  @observable
  StepState finishConfigStatus = StepState.indexed;

  @observable
  bool isWifiConfig = false;

  @observable
  bool isFinishConfig = false;

  @observable
  String? deviceName;

  @observable
  String? loadError;

  @observable
  String? errorDeviceName;

  @observable
  String? errorWifi;

  @observable
  WifiDTO wifiDTO = WifiDTO();

  @observable
  MqttDTO mqttDTO = MqttDTO();

  @action
  updateDeviceName(String? value) {
    deviceName = value;
  }

  @action
  updateErrorDeviceName(String? value) {
    errorDeviceName = value;
  }

  @action
  updateErrorWifi(String? value) {
    errorWifi = value;
  }

  @action
  updateSSID(String? value) {
    wifiDTO.ssid = value;
  }

  @action
  updatePassword(String? value) {
    wifiDTO.password = value;
  }

  @action
  changeDeviceConfig() {
    isDeviceConfig = !isDeviceConfig;
  }

  @action
  changeFinishConfigStatus(StepState status) {
    finishConfigStatus = status;
  }

  @action
  changeDeviceConfigStatus(StepState status) {
    deviceConfigStatus = status;
  }

  @action
  changeWifiConfigStatus(StepState status) {
    wifiConfigStatus = status;
  }

  @action
  setStep(int step) {
    if (step >= 0) {
      stepIndex = step;
    }
  }

  updateStepCancel(int step) {
    if (step < 0) {
      navigateToHome();
    } else {
      setStep(step);
    }
  }

  getClient() async {
    loadError = await _usecase.getClient();
  }

  updateStep() async {
    updateErrorDeviceName(_usecase.updateDeviceErrorName(deviceName));
    changeDeviceConfigStatus(
        await _usecase.updateDeviceConfig(stepIndex, deviceName));
    updateErrorWifi(_usecase.updateWifiError(wifiDTO, stepIndex));
    changeWifiConfigStatus(await _usecase.updateWifiConfig(stepIndex, wifiDTO));
    changeFinishConfigStatus(await _usecase.updateFinishConfig(stepIndex));
    var stepFinish = _usecase.updateStep(stepIndex);
    if (stepFinish <= 2) {
      setStep(stepFinish);
    } else {
      navigateToHome();
    }
  }

  navigateToHome() {
    Modular.to.navigate("/home/");
  }

  navigateToLogin() {
    Modular.to.navigate("/login/");
  }
}
