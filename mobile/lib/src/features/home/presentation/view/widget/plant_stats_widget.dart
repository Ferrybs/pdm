import 'package:basearch/src/features/home/domain/model/chart_serie.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlantStatsWidget extends StatelessWidget {
  final PlantStats plantStats;

  const PlantStatsWidget({
    Key? key,
    required this.plantStats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: _theme.colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(flex: 6, child: _createStatsGroup(_theme.textTheme)),
                Flexible(flex: 5, child: _createChart(_theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _createStatsGroup(TextTheme textTheme) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "#Plant",
            style: textTheme.headlineSmall,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                _stats("23", "Temperature", textTheme),
                _stats("12", "Water Tank", textTheme),
              ],
            ),
            Column(
              children: [
                _stats("41", "Moisture", textTheme),
                _stats("99", "Luminosity", textTheme),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _stats(String value, String label, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: textTheme.bodyLarge,
        ),
        Text(label, style: textTheme.labelMedium),
      ],
    );
  }

  _createChart(ThemeData theme) {
    List<charts.Series<ChartSerie, num>> timeline = [
      charts.Series(
        id: "Luminosity",
        data: plantStats.luminosityChart,
        seriesColor:
            charts.ColorUtil.fromDartColor(theme.colorScheme.onPrimary),
        domainFn: (ChartSerie timeline, _) => timeline.time,
        measureFn: (ChartSerie timeline, _) => timeline.value,
      )
    ];

    return Column(
      children: [
        SizedBox(
          height: 110,
          child: charts.LineChart(
            timeline,
            animate: true,
          ),
        ),
        Text("Luminosity", style: theme.textTheme.labelLarge),
      ],
    );
  }
}
