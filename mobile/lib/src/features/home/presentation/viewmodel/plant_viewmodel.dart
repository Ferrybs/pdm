import 'package:basearch/src/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'plant_viewmodel.g.dart';

class PlantViewModel = _PlantViewModelBase with _$PlantViewModel;

abstract class _PlantViewModelBase with Store {
  final _usecase = Modular.get<HomeUseCase>();
  @observable
  int currentChart = 0;

  @observable
  double temperature = 0;
  @observable
  double humidity = 0;
  @observable
  double luminosity = 0;
  @observable
  double moisture = 0;

  @action
  updateTemperature(double value) {
    temperature = value;
  }

  @action
  updateHumidity(double value) {
    humidity = value;
  }

  @action
  updateLuminosity(double value) {
    luminosity = value;
  }

  @action
  updateMoisture(double value) {
    moisture = value;
  }

  loadChat() async {}
}
