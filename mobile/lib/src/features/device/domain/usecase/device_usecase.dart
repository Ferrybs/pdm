import 'package:basearch/src/features/device/data/dto/device_dto.dart';
import 'package:basearch/src/features/device/data/dto/wifi_dto.dart';
import 'package:basearch/src/features/device/domain/model/device_config_model.dart';
import 'package:basearch/src/features/device/domain/model/wifi_model.dart';
import 'package:basearch/src/features/device/domain/repository/device_interface.dart';
import 'package:basearch/src/features/device/domain/model/device_model.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeviceUseCase {
  final repository = Modular.get<IDevice>();
  DeviceModel? deviceModel;
  WifiModel? wifiModel;
  DeviceConfigModel? deviceConfigModel;
  final encryptedPreferences = Modular.get<EncryptedSharedPreferences>();
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  String? get deviceId {
    return deviceModel?.id;
  }

  Future<StepState> updateDeviceConfig(int step) async {
    if (step == 0) {
      await flutterBlue.startScan(timeout: Duration(seconds: 4));
      var subscription = flutterBlue.scanResults.listen((results) {
        // do something with scan results
        for (ScanResult r in results) {
          print(
              'BLUE: ${r.device.name} found! rssi: ${r.advertisementData.serviceUuids}');
        }
      });
      flutterBlue.stopScan();
      deviceModel = await repository.getDeviceId();
      if (deviceModel?.id != null) {
        return StepState.complete;
      } else {
        return StepState.error;
      }
    }
    if (_deviceStepValidation()) {
      return StepState.complete;
    } else {
      return StepState.error;
    }
  }

  Future<StepState> updateWifiConfig(int step, WifiDTO wifiDTO) async {
    if (step == 1) {
      if (wifiDTO.ssid != null && wifiDTO.password != null) {
        wifiModel = WifiModel(ssid: wifiDTO.ssid, password: wifiDTO.password);
        var mqttModel = await repository
            .getMqttModel(await encryptedPreferences.getString("AccessToken"));
        var result = await repository.postDeviceConfig(
            DeviceConfigModel(wifi: wifiModel, mqtt: mqttModel));
        if (result) {
          return StepState.complete;
        }
        return StepState.error;
      } else {
        return StepState.error;
      }
    }
    if (step < 1) {
      return StepState.indexed;
    }
    if (step > 1 && !_wifiStepValidation()) {
      return StepState.error;
    }
    return StepState.complete;
  }

  Future<StepState> updateFinishConfig(int step, DeviceDTO deviceDTO) async {
    if (step == 2) {
      deviceModel?.name = deviceDTO.name;
      if (_finishStepValidation()) {
        return StepState.complete;
      } else {
        return StepState.error;
      }
    }
    if (step < 2) {
      return StepState.indexed;
    }
    if (step > 2 && !_finishStepValidation()) {
      return StepState.error;
    }
    return StepState.complete;
  }

  int updateStep(int step) {
    switch (step) {
      case 0:
        if (_deviceStepValidation()) {
          return 1;
        }
        return 0;
      case 1:
        if (_wifiStepValidation()) {
          return 2;
        }
        return 1;
      case 2:
        if (_finishStepValidation()) {
          return 3;
        }
        return 2;
      default:
    }
    return 0;
  }

  bool _deviceStepValidation() {
    if (deviceModel?.id != null) {
      return true;
    }
    return false;
  }

  bool _wifiStepValidation() {
    if (wifiModel?.ssid != null && wifiModel?.password != null) {
      return true;
    }
    return false;
  }

  bool _finishStepValidation() {
    if (deviceModel?.id != null &&
        (deviceModel?.name != null && deviceModel!.name!.length > 1)) {
      return true;
    }
    return false;
  }
}
