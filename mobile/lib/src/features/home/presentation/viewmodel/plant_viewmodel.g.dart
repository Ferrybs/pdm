// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlantViewModel on _PlantViewModelBase, Store {
  late final _$temperatureChartAtom =
      Atom(name: '_PlantViewModelBase.temperatureChart', context: context);

  @override
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> get temperatureChart {
    _$temperatureChartAtom.reportRead();
    return super.temperatureChart;
  }

  @override
  set temperatureChart(
      List<LineSeries<TimeSeriesMeasureModel, DateTime>> value) {
    _$temperatureChartAtom.reportWrite(value, super.temperatureChart, () {
      super.temperatureChart = value;
    });
  }

  late final _$humidityChartAtom =
      Atom(name: '_PlantViewModelBase.humidityChart', context: context);

  @override
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> get humidityChart {
    _$humidityChartAtom.reportRead();
    return super.humidityChart;
  }

  @override
  set humidityChart(List<LineSeries<TimeSeriesMeasureModel, DateTime>> value) {
    _$humidityChartAtom.reportWrite(value, super.humidityChart, () {
      super.humidityChart = value;
    });
  }

  late final _$luminosotyChartAtom =
      Atom(name: '_PlantViewModelBase.luminosotyChart', context: context);

  @override
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> get luminosotyChart {
    _$luminosotyChartAtom.reportRead();
    return super.luminosotyChart;
  }

  @override
  set luminosotyChart(
      List<LineSeries<TimeSeriesMeasureModel, DateTime>> value) {
    _$luminosotyChartAtom.reportWrite(value, super.luminosotyChart, () {
      super.luminosotyChart = value;
    });
  }

  late final _$moistureChartAtom =
      Atom(name: '_PlantViewModelBase.moistureChart', context: context);

  @override
  List<LineSeries<TimeSeriesMeasureModel, DateTime>> get moistureChart {
    _$moistureChartAtom.reportRead();
    return super.moistureChart;
  }

  @override
  set moistureChart(List<LineSeries<TimeSeriesMeasureModel, DateTime>> value) {
    _$moistureChartAtom.reportWrite(value, super.moistureChart, () {
      super.moistureChart = value;
    });
  }

  late final _$activeChartAtom =
      Atom(name: '_PlantViewModelBase.activeChart', context: context);

  @override
  List<bool> get activeChart {
    _$activeChartAtom.reportRead();
    return super.activeChart;
  }

  @override
  set activeChart(List<bool> value) {
    _$activeChartAtom.reportWrite(value, super.activeChart, () {
      super.activeChart = value;
    });
  }

  late final _$measureValuesAtom =
      Atom(name: '_PlantViewModelBase.measureValues', context: context);

  @override
  ObservableList<double> get measureValues {
    _$measureValuesAtom.reportRead();
    return super.measureValues;
  }

  @override
  set measureValues(ObservableList<double> value) {
    _$measureValuesAtom.reportWrite(value, super.measureValues, () {
      super.measureValues = value;
    });
  }

  late final _$_PlantViewModelBaseActionController =
      ActionController(name: '_PlantViewModelBase', context: context);

  @override
  dynamic updateMeasure(int index, double value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateMeasure');
    try {
      return super.updateMeasure(index, value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateMeasureList(List<double> value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateMeasureList');
    try {
      return super.updateMeasureList(value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateChartList(
      int index, List<LineSeries<TimeSeriesMeasureModel, DateTime>> value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateChartList');
    try {
      return super.updateChartList(index, value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateActiveChart(List<bool> value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateActiveChart');
    try {
      return super.updateActiveChart(value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
temperatureChart: ${temperatureChart},
humidityChart: ${humidityChart},
luminosotyChart: ${luminosotyChart},
moistureChart: ${moistureChart},
activeChart: ${activeChart},
measureValues: ${measureValues}
    ''';
  }
}
