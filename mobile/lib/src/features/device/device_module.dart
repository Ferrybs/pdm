import 'package:basearch/src/features/device/presentation/view/page/device_page.dart';
import 'package:basearch/src/features/modelo/presentation/view/page/modelo_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeviceModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const DevicePage(), children: []),
  ];
}
