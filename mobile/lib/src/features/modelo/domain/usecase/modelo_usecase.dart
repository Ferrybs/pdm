import 'package:basearch/src/features/modelo/domain/repository/modelo_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModeloUseCase {
  final repository = Modular.get<IModelo>();
}
