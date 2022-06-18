// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlantViewModel on _PlantViewModelBase, Store {
  late final _$currentChartAtom =
      Atom(name: '_PlantViewModelBase.currentChart', context: context);

  @override
  int get currentChart {
    _$currentChartAtom.reportRead();
    return super.currentChart;
  }

  @override
  set currentChart(int value) {
    _$currentChartAtom.reportWrite(value, super.currentChart, () {
      super.currentChart = value;
    });
  }

  late final _$temperatureAtom =
      Atom(name: '_PlantViewModelBase.temperature', context: context);

  @override
  double get temperature {
    _$temperatureAtom.reportRead();
    return super.temperature;
  }

  @override
  set temperature(double value) {
    _$temperatureAtom.reportWrite(value, super.temperature, () {
      super.temperature = value;
    });
  }

  late final _$humidityAtom =
      Atom(name: '_PlantViewModelBase.humidity', context: context);

  @override
  double get humidity {
    _$humidityAtom.reportRead();
    return super.humidity;
  }

  @override
  set humidity(double value) {
    _$humidityAtom.reportWrite(value, super.humidity, () {
      super.humidity = value;
    });
  }

  late final _$luminosityAtom =
      Atom(name: '_PlantViewModelBase.luminosity', context: context);

  @override
  double get luminosity {
    _$luminosityAtom.reportRead();
    return super.luminosity;
  }

  @override
  set luminosity(double value) {
    _$luminosityAtom.reportWrite(value, super.luminosity, () {
      super.luminosity = value;
    });
  }

  late final _$moistureAtom =
      Atom(name: '_PlantViewModelBase.moisture', context: context);

  @override
  double get moisture {
    _$moistureAtom.reportRead();
    return super.moisture;
  }

  @override
  set moisture(double value) {
    _$moistureAtom.reportWrite(value, super.moisture, () {
      super.moisture = value;
    });
  }

  late final _$_PlantViewModelBaseActionController =
      ActionController(name: '_PlantViewModelBase', context: context);

  @override
  dynamic updateTemperature(double value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateTemperature');
    try {
      return super.updateTemperature(value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateHumidity(double value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateHumidity');
    try {
      return super.updateHumidity(value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateLuminosity(double value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateLuminosity');
    try {
      return super.updateLuminosity(value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateMoisture(double value) {
    final _$actionInfo = _$_PlantViewModelBaseActionController.startAction(
        name: '_PlantViewModelBase.updateMoisture');
    try {
      return super.updateMoisture(value);
    } finally {
      _$_PlantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentChart: ${currentChart},
temperature: ${temperature},
humidity: ${humidity},
luminosity: ${luminosity},
moisture: ${moisture}
    ''';
  }
}
