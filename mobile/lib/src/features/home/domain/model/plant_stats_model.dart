import 'package:basearch/src/features/home/domain/model/chart_serie.dart';

class PlantStatsModel {
  const PlantStatsModel(
    this.name,
    this.temperature,
    this.moisture,
    this.waterTank,
    this.luminosity,
    this.luminosityChart,
    this.temperatureChart,
    this.moistureChart,
  );
  final String name;
  final double temperature;
  final double moisture;
  final double waterTank;
  final double luminosity;
  final List<ChartSerie> luminosityChart;
  final List<ChartSerie> moistureChart;
  final List<ChartSerie> temperatureChart;
}
