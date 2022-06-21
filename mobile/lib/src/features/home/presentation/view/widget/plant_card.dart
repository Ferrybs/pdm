import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/domain/model/time_series_measure_model.dart';
import 'package:basearch/src/features/home/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:basearch/src/features/home/presentation/viewmodel/plant_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:localization/localization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlantCard extends StatefulWidget {
  final DeviceDTO deviceDTO;
  const PlantCard({Key? key, required this.deviceDTO}) : super(key: key);

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  final _homeViewModel = Modular.get<HomeViewModel>();
  final _plantViewModel = Modular.get<PlantViewModel>();
  late Future<int> loadData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    _plantViewModel.loadMeasureValues(widget.deviceDTO);
    loadData = _plantViewModel.loadChart(widget.deviceDTO.id, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          color: _theme.backgroundColor,
          child: Column(
            children: [
              _chartBuilder(_theme),
              SizedBox(
                width: MediaQuery.of(context).size.width - 45,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: ExpansionTile(
                      backgroundColor: _theme.backgroundColor,
                      title: Text(widget.deviceDTO.name),
                      children: [
                        _preferenceBar(
                            _theme, "temperature".i18n(), 0, "°C", 100),
                        _preferenceBar(_theme, "humidity".i18n(), 1, "%", 100),
                        _preferenceBar(
                            _theme, "luminosity".i18n(), 2, "LUX", 100000),
                        _preferenceBar(_theme, "moisture".i18n(), 3, "%", 100),
                        TextButton(
                            onPressed: () {
                              _save(_theme);
                            },
                            child: Text("save".i18n()))
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

  _save(ThemeData _theme) async {
    SmartDialog.showLoading(
        msg: "loading".i18n(), background: _theme.colorScheme.background);
    await _plantViewModel.save(widget.deviceDTO);
    SmartDialog.dismiss();
  }

  Observer _preferenceBar(ThemeData _theme, String preferenceName,
      int preferenceIdx, String unity, double max) {
    return Observer(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(preferenceName.toUpperCase() +
                    ": " +
                    _plantViewModel.measureValues[preferenceIdx].toString() +
                    " " +
                    unity),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Switch(
                    activeColor: _theme.colorScheme.primary,
                    value: _plantViewModel.activeChart[preferenceIdx],
                    onChanged: (bool _tempChart) {
                      loadData = _plantViewModel.loadChart(
                          widget.deviceDTO.id, preferenceIdx, preferenceIdx);
                      _plantViewModel.selectChart(preferenceIdx, _tempChart);
                      setState(() {});
                    }),
              ),
            ],
          ),
          Slider(
              value: _plantViewModel.measureValues[preferenceIdx],
              min: 0,
              max: max,
              onChanged: (double value) {
                _plantViewModel.updateMeasure(
                    preferenceIdx, value.truncateToDouble());
                setState(() {});
              })
        ],
      );
    });
  }

  FutureBuilder<int> _chartBuilder(ThemeData _theme) {
    return FutureBuilder<int>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_homeViewModel.error != null) {
            return Container(
              color: _theme.colorScheme.background,
              child: DialogContainer(
                message: _homeViewModel.error ?? "session-error-tittle".i18n(),
                buttonText: "try-again".i18n(),
                onClick: () {
                  _homeViewModel.navigateToLogin();
                },
              ),
            );
          } else {
            switch (snapshot.data) {
              case 0:
                return _chart(_theme, context, _plantViewModel.temperatureChart,
                    "temperature".i18n());
              case 1:
                return _chart(_theme, context, _plantViewModel.humidityChart,
                    "humidity".i18n());
              case 2:
                return _chart(_theme, context, _plantViewModel.luminosotyChart,
                    "luminosity".i18n());
              case 3:
                return _chart(_theme, context, _plantViewModel.moistureChart,
                    "moisture".i18n());
              default:
            }
          }
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      future: loadData,
    );
  }

  SizedBox _chart(
      ThemeData _theme,
      BuildContext context,
      List<LineSeries<TimeSeriesMeasureModel, DateTime>> data,
      String chartName) {
    final now = DateTime.now().toUtc();
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SfCartesianChart(
            enableAxisAnimation: false,
            primaryXAxis: DateTimeAxis(
                maximum: DateTime(now.year, now.month, now.day - 1),
                minimum: DateTime(
                    now.year, now.month, now.day, now.hour, now.minute + 5)),
            title: ChartTitle(
                text: chartName, textStyle: _theme.textTheme.bodyMedium),
            legend: Legend(
              isVisible: false,
            ),
            series: data,
            tooltipBehavior: _tooltipBehavior,
          ),
        ),
      ),
    );
  }
}
