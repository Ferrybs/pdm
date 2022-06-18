import 'package:basearch/src/features/home/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/home/presentation/view/widget/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../viewmodel/home_viewmodel.dart';

class HomePlantPage extends StatefulWidget {
  const HomePlantPage({Key? key}) : super(key: key);
  @override
  State<HomePlantPage> createState() => _HomePlantPage();
}

class _HomePlantPage extends State<HomePlantPage> {
  late ThemeData _theme;
  final _viewModel = Modular.get<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Observer(
        builder: (_) => FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError || _viewModel.error != null) {
                    return _loadErrorMessage();
                  } else {
                    return _body();
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: _viewModel.getHomeData(),
            ));
  }

  SafeArea _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              _createTitle(_viewModel.gethomeTittle()),
              PlantCard(seriesList: _createSampleData())
            ],
          ),
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  Container _loadErrorMessage() {
    return Container(
      color: _theme.colorScheme.background,
      child: DialogContainer(
        message: _viewModel.error ?? "session-error-tittle".i18n(),
        buttonText: "try-again".i18n(),
        onClick: () {
          _viewModel.navigateToLogin();
        },
      ),
    );
  }

  _createTitle(String tittle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        tittle,
        style: _theme.textTheme.headlineMedium,
      ),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
