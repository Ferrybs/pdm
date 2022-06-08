import 'package:basearch/src/features/device/data/dto/device_dto.dart';
import 'package:basearch/src/features/device/data/dto/wifi_dto.dart';
import 'package:basearch/src/features/device/domain/model/blu_device_config_model.dart';
import 'package:basearch/src/features/device/domain/model/client_model.dart';
import 'package:basearch/src/features/device/domain/model/device_config_model.dart';
import 'package:basearch/src/features/device/domain/model/wifi_model.dart';
import 'package:basearch/src/features/device/domain/repository/device_interface.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'dart:convert';

class DeviceUseCase {
  final repository = Modular.get<IDevice>();
  BluDeviceConfigModel? bluDeviceConfigModel;
  ClientModel? clientModel;
  DeviceConfigModel? deviceConfigModel;
  BluetoothDevice? device;
  WifiModel? wifiModel;
  String? _deviceName;
  final encryptedPreferences = Modular.get<EncryptedSharedPreferences>();
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  String? updateDeviceErrorName(String name) {
    if (name.length > 2) {
      return null;
    }
    return "error-device-name".i18n();
  }

  String? updateWifiError(WifiDTO wifiDTO, int step) {
    if (step > 0) {
      String ssid = wifiDTO.ssid ?? '';
      String password = wifiDTO.password ?? '';
      if (ssid.length > 2 && password.length > 2) {
        return null;
      }
      return "error-wifi".i18n();
    }
    return null;
  }

  Future<bool> getDeviceConfigModel() async {
    String token = await encryptedPreferences.getString("AccessToken");
    try {
      clientModel = await repository.getClient(token);
      deviceConfigModel = await repository.getDeviceConfigs(token);
      if (clientModel != null && deviceConfigModel != null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<StepState> updateDeviceConfig(int step, String deviceName) async {
    if (step == 0) {
      _deviceName = deviceName;
      print(_deviceName);
      if (deviceName.length > 2 && await getDeviceConfigModel()) {
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

  Future<BluetoothDevice?> _connectToDevice(BluetoothDevice device) async {
    try {
      BluetoothDeviceState state = await device.state.first;
      if (state == BluetoothDeviceState.connected) {
        return device;
      }
      await device.connect(
          timeout: const Duration(seconds: 5), autoConnect: true);
    } catch (e) {
      return null;
    }
    return device;
  }

  Future<BluetoothDevice?> _findDevice() async {
    List<BluetoothDevice> deviceList = await flutterBlue.connectedDevices;
    if (deviceList.isNotEmpty) {
      for (BluetoothDevice d in deviceList) {
        if (d.name.toUpperCase().contains("ESP32")) {
          return d;
        }
      }
    }
    await flutterBlue.startScan(timeout: const Duration(seconds: 3));
    flutterBlue.stopScan();
    List<ScanResult> results = await flutterBlue.scanResults.first;
    for (ScanResult result in results) {
      print(result.device.name.toUpperCase());
      if (result.device.name.toUpperCase().contains("ESP32")) {
        return await _connectToDevice(result.device);
      }
    }
    return null;
  }

  Future<BluetoothCharacteristic?> _selectCharacteristic(
      BluetoothService service, String chart) async {
    List<BluetoothCharacteristic> characteristics = service.characteristics;
    for (BluetoothCharacteristic c in characteristics) {
      if (c.uuid.toString() == chart) {
        return c;
      }
    }
    return null;
  }

  Future<bool> _writeConfigs(
      BluetoothDevice device, List<int> hexString) async {
    List<BluetoothService> services = await device.discoverServices();
    BluetoothCharacteristic? blue;
    for (var service in services) {
      if (service.uuid.toString() == "6e400001-b5a3-f393-e0a9-e50e24dcca9e") {
        blue = await _selectCharacteristic(
            service, "6e400002-b5a3-f393-e0a9-e50e24dcca9e");
      }
    }
    if (blue != null) {
      print("WRITE");
      print(blue.uuid);
      print(hexString);
      await blue.write(hexString);
      await device.disconnect();
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>?> _readConfigs(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    BluetoothCharacteristic? blue;
    for (var service in services) {
      if (service.uuid.toString() == "6e400001-b5a3-f393-e0a9-e50e24dcca9e") {
        blue = await _selectCharacteristic(
            service, "6e400003-b5a3-f393-e0a9-e50e24dcca9e");
      }
    }
    if (blue != null) {
      List<int> hex = await blue.read();
      List<String> stringHex = [];
      print("READ: ${hex.length}");
      for (var i in hex) {
        stringHex.add(String.fromCharCode(i));
      }
      print(json.decode(stringHex.join()));
      return json.decode(stringHex.join());
    }
    return null;
  }

  bool _wifiStepValidation() {
    if (wifiModel != null && validateBluDeviceConfig()) {
      return true;
    }
    return false;
  }

  bool validateBluDeviceConfig() {
    if (bluDeviceConfigModel?.id != null &&
        bluDeviceConfigModel?.key != null &&
        bluDeviceConfigModel?.mqtt != null &&
        bluDeviceConfigModel?.name != null &&
        bluDeviceConfigModel?.wifi != null) {
      return true;
    }
    return false;
  }

  Future<StepState> updateWifiConfig(int step, WifiDTO wifiDTO) async {
    if (step == 1) {
      if (wifiDTO.ssid!.length > 2 && wifiDTO.password!.length > 2) {
        wifiModel = WifiModel(ssid: wifiDTO.ssid!, password: wifiDTO.password!);
        try {
          bluDeviceConfigModel = BluDeviceConfigModel(
              id: clientModel!.id!,
              key: deviceConfigModel!.key!,
              name: _deviceName!,
              mqtt: deviceConfigModel!.mqtt!,
              wifi: wifiModel!);
        } catch (e) {
          return StepState.error;
        }
        return StepState.complete;
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

  bool _finishStepValidation() {
    if (bluDeviceConfigModel != null) {
      return true;
    }
    return false;
  }

  Future<StepState> updateFinishConfig(int step) async {
    if (step == 2) {
      if (_finishStepValidation()) {
        try {
          //List<int> hexString = [];
          device = await _findDevice();
          String bluString = bluDeviceConfigModel!.toJson().toString();
          print(bluString);
          if (device != null) {
            await _writeConfigs(device!, bluString.codeUnits);
          }
          return StepState.error;
        } catch (e) {
          print(e);
          return StepState.error;
        }
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

  bool _deviceStepValidation() {
    String deviceName = _deviceName ?? '';
    if (deviceConfigModel != null && deviceName.length > 2) {
      return true;
    }
    return false;
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
          return 2;
        }
        return 2;
      default:
    }
    return 0;
  }
}
