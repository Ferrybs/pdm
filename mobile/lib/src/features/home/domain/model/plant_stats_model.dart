import 'package:basearch/src/features/home/domain/model/chart_serie.dart';

class PlantStatsModel {
  const PlantStatsModel({
    required this.name,
    required this.temperature,
    required this.moisture,
    required this.waterTank,
    required this.luminosity,
    required this.temperatureChart,
    required this.moistureChart,
    required this.luminosityChart,
  });
  final String name;
  final double temperature;
  final double moisture;
  final double waterTank;
  final double luminosity;
  final List<ChartSerie> luminosityChart;
  final List<ChartSerie> moistureChart;
  final List<ChartSerie> temperatureChart;
}
