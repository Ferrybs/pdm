import 'package:basearch/src/features/map/data/repository/map_repository.dart';
import 'package:basearch/src/features/map/domain/repository/map_interface.dart';
import 'package:basearch/src/features/map/domain/usecase/map_usecase.dart';
import 'package:basearch/src/features/map/presentation/view/page/map_page.dart';
import 'package:basearch/src/features/map/presentation/viewmodel/map_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MapModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<Imap>((i) => MapRepository()),
    Bind.factory((i) => MapViewModel()),
    Bind.factory((i) => MapUsecase())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const MapPage(), children: []),
  ];
}
