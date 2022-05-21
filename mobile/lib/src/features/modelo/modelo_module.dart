import 'package:basearch/src/features/modelo/presentation/view/page/modelo_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModeloModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const ModeloPage(), children: []),
  ];
}
