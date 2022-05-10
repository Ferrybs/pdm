import 'package:basearch/src/features/home/presentation/view/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

import '../../viewmodel/home_viewmodel.dart';
import '../widget/plant_stats_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends ModularState<HomePage, HomeViewModel> {
  final _viewModel = Modular.get<HomeViewModel>();
  bool showSpinner = false;
  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              _createTitle(),
              ..._createPlantList(),
            ],
          ),
        ),
      ),
    );
  }

  _createTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        store.userName + ", " + "home_title".i18n(),
        style: _theme.textTheme.headlineMedium,
      ),
    );
  }

  _createPlantList() {
    return store.plantList
        .map((plant) => PlantStatsWidget(plantStats: plant))
        .toList();
  }
}
