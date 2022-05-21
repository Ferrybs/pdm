import 'package:basearch/src/features/modelo/domain/repository/device_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeviceUseCase {
  final repository = Modular.get<IDevice>();
}
