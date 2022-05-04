import 'package:basearch/src/features/home/domain/model/chart_serie.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/home_usecase.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final _usecase = Modular.get<HomeUseCase>();

  @observable
  String userName = "";

  @observable
  List<PlantStatsModel> plantList = [];

  _HomeViewModelBase() {
    init();
  }

  @action
  init() async {
    userName = await _usecase.getUserName();
    plantList = await _usecase.getPlantList();
  }
}
