import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/domain/model/time_series_measure_model.dart';
import 'package:basearch/src/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'plant_viewmodel.g.dart';

class PlantViewModel = _PlantViewModelBase with _$PlantViewModel;

abstract class _PlantViewModelBase with Store {
  final _usecase = Modular.get<HomeUseCase>();

  @observable
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> temperatureChart = [];

  @observable
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> humidityChart = [];
  @observable
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> luminosotyChart = [];
  @observable
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> moistureChart = [];

  @observable
  List<bool> activeChart = [true, false, false, false];

  @observable
  ObservableList<double> measureValues = ObservableList.of([0, 0, 0, 0]);

  @action
  updateMeasure(int index, double value) {
    measureValues[index] = value;
  }

  @action
  updateMeasureList(List<double> value) {
    measureValues = value.asObservable();
  }

  @action
  updateChartList(
      int index, List<LineSeries<TimeSeriesMeasureModel, DateTime>> value) {
    switch (index) {
      case 0:
        temperatureChart = value;
        break;
      case 1:
        humidityChart = value;
        break;
      case 2:
        luminosotyChart = value;
        break;
      case 3:
        moistureChart = value;
        break;
      default:
    }
  }

  @action
  updateActiveChart(List<bool> value) {
    activeChart = value;
  }

  bool selectChart(int index, isActive) {
    if (isActive) {
      updateActiveChart(_usecase.selectChart(index, activeChart));
      return activeChart[index];
    }
    return true;
  }

  Future<int> loadChart(String deviceId, int chartidx, int index) async {
    updateChartList(
        index,
        await _usecase.getChartMeasure(
            deviceId, chartidx.toString(), (index + 1).toString()));
    return index;
  }

  loadMeasureValues(DeviceDTO deviceDTO) async {
    updateMeasureList(await _usecase.getMeasureValues(deviceDTO));
  }

  save(DeviceDTO deviceDTO) async {
    await _usecase.setPreferences(measureValues, deviceDTO);
  }
}
