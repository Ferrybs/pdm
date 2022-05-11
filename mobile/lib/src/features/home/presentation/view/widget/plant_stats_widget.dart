import 'package:basearch/src/features/home/domain/model/chart_serie.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:localization/localization.dart';

class PlantStatsWidget extends StatelessWidget {
  final PlantStatsModel plantStats;

  const PlantStatsWidget({
    Key? key,
    required this.plantStats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
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
                Flexible(flex: 4, child: _createChart(_theme)),
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
            plantStats.name,
            style: textTheme.headlineSmall,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stats(
                  plantStats.temperature.toString(),
                  "Cº",
                  "temperature".i18n(),
                  textTheme,
                ),
                _stats(
                  plantStats.waterTank.toString(),
                  "%",
                  "water_tank".i18n(),
                  textTheme,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stats(
                  plantStats.moisture.toString(),
                  "%",
                  "moisture".i18n(),
                  textTheme,
                ),
                _stats(
                  plantStats.luminosity.toString(),
                  "%",
                  "luminosity".i18n(),
                  textTheme,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _stats(String value, String sufix, String label, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: textTheme.bodyLarge,
            ),
            Text(
              sufix,
              style: textTheme.bodySmall,
            ),
          ],
        ),
        Text(label, style: textTheme.labelMedium),
      ],
    );
  }

  _createChart(ThemeData theme) {
    List<charts.Series<ChartSerie, num>> timeline = [
      charts.Series(
        id: "luminosity".i18n(),
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
            primaryMeasureAxis: const charts.NumericAxisSpec(
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  zeroBound: true, desiredMinTickCount: 4),
            ),
            animate: true,
          ),
        ),
        Text("luminosity".i18n(), style: theme.textTheme.labelLarge),
      ],
    );
  }
}
