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
  String? error;

  @observable
  List<PlantStatsModel> plantList = [];

  @action
  void updateClientName(String name) {
    clientName = name;
  }

  @action
  void updateError(String? value) {
    error = value;
  }

  @action
  void updatePlantList(List<PlantStatsModel> list) {
    plantList = list;
  }

  getHomeData() async {
    updateError(await _usecase.getClient());
    String? name = _usecase.getUserName();
    if (name != null) {
      updateError(null);
      updateClientName(name);
    } else {
      updateError("error-home-tittle".i18n());
    }
    List<PlantStatsModel>? list = await _usecase.getPlantList();
    if (list != null) {
      updatePlantList(list);
    }
  }

  String gethomeTittle() {
    if (clientName != null) {
      return clientName! + ", " + "home-tittle".i18n();
    } else {
      return "error-home-tittle".i18n();
    }
  }

  void navigateToLogin() {
    Modular.to.navigate("/auth/");
  }

  void navigateToMap() {
    Modular.to.navigate('/map/');
  }
}