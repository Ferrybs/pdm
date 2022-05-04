import 'package:basearch/src/features/home/domain/model/chart_serie.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecase/home_usecase.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final _usecase = Modular.get<HomeUseCase>();

  @observable
  String name = "[NAME]";

  @observable
  List<PlantStats> plantList = [
    PlantStats(
      "name",
      32,
      34,
      23,
      32,
      [
        ChartSerie(time: 1, value: 4),
        ChartSerie(time: 2, value: 3),
        ChartSerie(time: 3, value: 7)
      ],
      [ChartSerie(time: 1, value: 4)],
      [ChartSerie(time: 1, value: 4)],
    )
  ];
}
