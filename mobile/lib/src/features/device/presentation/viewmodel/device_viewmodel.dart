import 'package:basearch/src/features/device/domain/usecase/modelo_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'device_viewmodel.g.dart';

class DeviceViewModel = _DeviceViewModel with _$DeviceViewModel;

abstract class _DeviceViewModel with Store {
  final _usecase = Modular.get<DeviceUseCase>();

  @observable
  String? clientName;
}
