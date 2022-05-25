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
  bool isWirelessConfig = false;

  @observable
  bool isFinishConfig = false;

  @observable
  WifiDTO wifiDTO = WifiDTO();

  @observable
  MqttDTO mqttDTO = MqttDTO();

  @observable
  DeviceDTO deviceDTO = DeviceDTO();

  @action
  changeDeviceConfig() {
    isDeviceConfig = !isDeviceConfig;
  }

  @action
  changeDeviceConfigStatus(StepState status) {
    deviceConfigStatus = status;
  }

  @action
  changeWirelessConfig() {
    isWirelessConfig = !isWirelessConfig;
  }

  @action
  changeFinishConfig() {
    isFinishConfig = !isFinishConfig;
  }

  @action
  increaseStep() {
    stepIndex++;
  }

  @action
  decreaseStep() {
    if (stepIndex > 0) {
      stepIndex--;
    }
  }

  @action
  setStep(int step) {
    stepIndex = step;
  }

  onStepContinue() {
    if (stepIndex == 1) {}
  }

  updateStep() {
    changeDeviceConfigStatus(_usecase.updateDeviceConfig(stepIndex, deviceDTO));
    setStep(_usecase.updateStep(stepIndex, deviceConfigStatus));
  }
}
