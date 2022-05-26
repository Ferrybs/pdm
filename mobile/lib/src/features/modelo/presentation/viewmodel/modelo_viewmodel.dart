import 'package:basearch/src/features/modelo/domain/usecase/modelo_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'modelo_viewmodel.g.dart';

class ModeloViewModel = _ModeloViewModel with _$ModeloViewModel;

abstract class _ModeloViewModel with Store {
  final _usecase = Modular.get<ModeloUseCase>();
}
