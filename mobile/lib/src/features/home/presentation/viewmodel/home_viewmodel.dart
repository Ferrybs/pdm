import 'package:basearch/src/features/home/domain/model/chart_serie.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:localization/localization.dart';
import '../../domain/usecase/home_usecase.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final _usecase = Modular.get<HomeUseCase>();

  @observable
  String? clientName;

  @observable
  List<PlantStatsModel> plantList = [];

  Future<String> gethomeTittle() async {
    clientName = await _usecase.getUserName();
    if (clientName != null) {
      return clientName! + ", " + "home_title".i18n();
    } else {
      return "error".i18n();
    }
  }
}
