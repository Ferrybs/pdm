import 'package:basearch/src/features/map/presentation/view/page/map_page.dart';
import 'package:basearch/src/features/map/presentation/viewmodel/map_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MapModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => MapViewModel()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const MapPage(), children: []),
  ];
}
