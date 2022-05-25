import 'package:basearch/src/features/device/data/dto/mqtt_dto.dart';
import 'package:basearch/src/features/device/domain/repository/modelo_interface.dart';
import 'package:basearch/src/features/device/data/dto/device_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeviceUseCase {
  final repository = Modular.get<IDevice>();

  StepState updateDeviceConfig(int step, DeviceDTO deviceDTO) {
    if (step == 0) {
      if (deviceDTO.id != null) {
        return StepState.complete;
      } else {
        return StepState.error;
      }
    }
    return StepState.complete;
  }

  int updateStep(int step, StepState state) {
    if (state == StepState.complete) {
      if (step < 2) {
        return step + 1;
      }
      return step;
    }
    if (state == StepState.error) {
      if (step <= 0) {
        return 0;
      }
      return step - 1;
    }
    return step;
  }
}
