import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlantCard extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  const PlantCard({Key? key, required this.seriesList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 200,
            child: Card(
              child: charts.TimeSeriesChart(seriesList),
            ),
          )
        ],
      ),
    );
  }
}
