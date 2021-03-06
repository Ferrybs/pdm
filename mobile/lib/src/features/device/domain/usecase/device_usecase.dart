import 'dart:async';
import 'package:basearch/src/features/device/data/dto/wifi_dto.dart';
import 'package:basearch/src/features/device/domain/model/blu_device_config_model.dart';
import 'package:basearch/src/features/device/domain/model/client_model.dart';
import 'package:basearch/src/features/device/domain/model/device_config_model.dart';
import 'package:basearch/src/features/device/domain/model/response_model.dart';
import 'package:basearch/src/features/device/domain/model/wifi_model.dart';
import 'package:basearch/src/features/device/domain/repository/device_interface.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'dart:convert';

class DeviceUseCase {
  final _repository = Modular.get<IDevice>();
  final _preference = Modular.get<PreferenceUsecase>();
  BluDeviceConfigModel? _bluDeviceConfigModel;
  bool _isConfigured = false;
  ClientModel? _clientModel;
  DeviceConfigModel? _deviceConfigModel;
  BluetoothDevice? _device;
  WifiModel? wifiModel;
  String? _deviceName;
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  String? updateDeviceErrorName(String? name) {
    String _name = name ?? "";
    if (_name.length > 2) {
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

  Future<String?> getClient() async {
    String? token = await _preference.getAccessToken();
    if (token != null) {
      _clientModel = await _repository.getClient(token);
    }
    if (_clientModel != null) {
      return null;
    }
    return "session-error-tittle".i18n();
  }

  Future<bool> getDeviceConfigModel() async {
    String? token = await _preference.getAccessToken();
    try {
      if (token != null) {
        _clientModel = _clientModel ?? await _repository.getClient(token);
        _deviceConfigModel = await _repository.getDeviceConfigs(token);
      }
      if (_clientModel != null && _deviceConfigModel != null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<StepState> updateDeviceConfig(int step, String? deviceName) async {
    if (step == 0) {
      _deviceName = deviceName ?? "";
      if (_deviceName!.length > 2 && await getDeviceConfigModel()) {
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
      state = await device.state.first;
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
    await flutterBlue.startScan(timeout: const Duration(seconds: 5));
    await flutterBlue.stopScan();
    List<ScanResult> results = await flutterBlue.scanResults.first;
    for (ScanResult result in results) {
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
      await blue.write(
        hexString,
      );
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>> _readConfigs(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    BluetoothCharacteristic? blue;
    for (var service in services) {
      if (service.uuid.toString() == "6e400001-b5a3-f393-e0a9-e50e24dcca9e") {
        blue = await _selectCharacteristic(
            service, "6e400003-b5a3-f393-e0a9-e50e24dcca9e");
      }
    }
    if (blue != null) {
      List<String> stringHex = [];
      List<int> hex = [];
      BluetoothDeviceState state = await device.state.first;
      while (hex.isEmpty && state == BluetoothDeviceState.connected) {
        hex = await blue.read();
        state = await device.state.first;
      }
      if (hex.isNotEmpty) {
        for (var i in hex) {
          stringHex.add(String.fromCharCode(i));
        }
        return json.decode(stringHex.join());
      }
    }
    return ResponseModel(message: "device-not-found", ok: false).toJson();
  }

  bool _wifiStepValidation() {
    if (wifiModel != null && validateBluDeviceConfig()) {
      return true;
    }
    return false;
  }

  bool validateBluDeviceConfig() {
    if (_bluDeviceConfigModel?.id != null &&
        _bluDeviceConfigModel?.key != null &&
        _bluDeviceConfigModel?.mqtt != null &&
        _bluDeviceConfigModel?.name != null &&
        _bluDeviceConfigModel?.wifi != null) {
      return true;
    }
    return false;
  }

  Future<StepState> updateWifiConfig(int step, WifiDTO wifiDTO) async {
    if (step == 1) {
      String ssid = wifiDTO.ssid ?? "";
      String password = wifiDTO.password ?? "";
      if (ssid.length > 2 && password.length > 2) {
        wifiModel = WifiModel(ssid: wifiDTO.ssid!, password: wifiDTO.password!);
        try {
          _bluDeviceConfigModel = BluDeviceConfigModel(
              id: _clientModel!.id!,
              key: _deviceConfigModel!.key!,
              name: _deviceName!,
              mqtt: _deviceConfigModel!.mqtt!,
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
    if (_bluDeviceConfigModel != null && _isConfigured) {
      return true;
    }
    return false;
  }

  Future<StepState> updateFinishConfig(int step) async {
    if (step == 2) {
      if (_bluDeviceConfigModel != null) {
        try {
          _device = await _findDevice();
          String bluString = _bluDeviceConfigModel!.toJson().toString();
          if (_device != null) {
            await _writeConfigs(_device!, bluString.codeUnits);
          }
          ResponseModel responseModel =
              ResponseModel.fromJson(await _readConfigs(_device!));

          if (responseModel.ok == true) {
            _isConfigured = true;
            return StepState.complete;
          } else {
            return StepState.error;
          }
        } catch (e) {
          return StepState.error;
        }
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
    if (_deviceConfigModel != null && deviceName.length > 2) {
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
          return 3;
        }
        return 1;
      default:
    }
    return 0;
  }
}
