import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:basearch/src/features/home/presentation/viewmodel/plant_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlantCard extends StatefulWidget {
  final DeviceDTO deviceDTO;
  PlantCard({Key? key, required this.deviceDTO}) : super(key: key);

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  final _homeViewModel = Modular.get<HomeViewModel>();
  final _plantViewModel = Modular.get<PlantViewModel>();
  double temperatureValue = 0;
  bool tempChart = true;
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
                            _viewModel.,
                            layoutConfig: charts.LayoutConfig(
                                bottomMarginSpec:
                                    charts.MarginSpec.fixedPixel(25),
                                leftMarginSpec:
                                    charts.MarginSpec.fixedPixel(20),
                                rightMarginSpec:
                                    charts.MarginSpec.fixedPixel(10),
                                topMarginSpec:
                                    charts.MarginSpec.fixedPixel(10)),
                            primaryMeasureAxis: charts.NumericAxisSpec(
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
                      title: Text("DEVICE NAME"),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Text("TEMPERATURE: " +
                                      temperatureValue.toString()),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Switch(
                                      activeColor: _theme.colorScheme.primary,
                                      value: tempChart,
                                      onChanged: (bool _tempChart) {
                                        setState(() {
                                          tempChart = _tempChart;
                                        });
                                      }),
                                ),
                              ],
                            ),
                            Slider(
                                value: temperatureValue,
                                min: 0,
                                max: 100,
                                onChanged: (double value) {
                                  setState(() {
                                    temperatureValue = value.truncateToDouble();
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
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
