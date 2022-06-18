import 'dart:math';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: _theme.backgroundColor,
          child: Column(
            children: [
              FutureBuilder(builder: (context, snapshot) {
                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          elevation: 8,
                          child: charts.TimeSeriesChart(
                            seriesList,
                            layoutConfig: charts.LayoutConfig(
                                bottomMarginSpec:
                                    charts.MarginSpec.fixedPixel(25),
                                leftMarginSpec:
                                    charts.MarginSpec.fixedPixel(20),
                                rightMarginSpec:
                                    charts.MarginSpec.fixedPixel(10),
                                topMarginSpec:
                                    charts.MarginSpec.fixedPixel(10)),
                            primaryMeasureAxis: new charts.NumericAxisSpec(
                                renderSpec: charts.GridlineRendererSpec(
                                    lineStyle: charts.LineStyleSpec(
                                        dashPattern: [4, 4]))),
                          )),
                    ),
                    Text("MEASURE"),
                  ],
                );
              }),
              SizedBox(
                width: MediaQuery.of(context).size.width - 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: ExpansionTile(
                        backgroundColor: _theme.backgroundColor,
                        title: Text("DEVICE NAME")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
