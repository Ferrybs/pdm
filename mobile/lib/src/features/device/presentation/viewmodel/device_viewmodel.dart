import 'package:basearch/src/features/device/data/dto/device_dto.dart';
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
  String name = '';

  @observable
  String errorName = '';

  @observable
  WifiDTO wifiDTO = WifiDTO();

  @observable
  MqttDTO mqttDTO = MqttDTO();

  @observable
  DeviceDTO deviceDTO = DeviceDTO();

  @action
  updateName(String value) {
    name = value;
  }

  @action
  updateErrorName(String value) {
    errorName = value;
  }

  @action
  updateSSID(String value) {
    wifiDTO.ssid = value;
  }

  @action
  updatePassword(String value) {
    wifiDTO.password = value;
  }

  @action
  updateDeviceName(String value) {
    deviceDTO.name = value;
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

  updateStep() async {
    String? error = _usecase.updateErrorName(name);
    if (error == null) {
      updateErrorName('');
      changeDeviceConfigStatus(
          await _usecase.updateDeviceConfig(stepIndex, name));
    } else {
      updateErrorName(error);
    }
    changeWifiConfigStatus(await _usecase.updateWifiConfig(stepIndex, wifiDTO));
    changeFinishConfigStatus(
        await _usecase.updateFinishConfig(stepIndex, deviceDTO));
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
}
