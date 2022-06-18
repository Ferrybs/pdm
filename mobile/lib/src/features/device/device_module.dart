import 'package:basearch/src/features/device/data/repository/device_repository.dart';
import 'package:basearch/src/features/device/domain/repository/device_interface.dart';
import 'package:basearch/src/features/device/domain/usecase/device_usecase.dart';
import 'package:basearch/src/features/device/presentation/view/page/device_page.dart';
import 'package:basearch/src/features/device/presentation/view/page/device_page_edit.dart';
import 'package:basearch/src/features/device/presentation/viewmodel/device_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeviceModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => DeviceViewModel()),
    Bind.factory((i) => DeviceUseCase()),
    Bind.factory<IDevice>((i) => DeviceRepository())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const DevicePage(), children: []),
    ChildRoute('/edit', child: (_, __) => const DevicePageEdit(), children: [])
  ];
}
