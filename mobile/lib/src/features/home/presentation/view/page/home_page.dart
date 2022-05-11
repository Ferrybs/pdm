import 'package:basearch/src/features/home/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/home/presentation/view/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:localization/colored_print/print_color.dart';
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
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: const HomeAppBar(),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: DialogContainer(
                  message: snapshot.error.toString(),
                  buttonText: "try-agin".i18n(),
                  onClick: () {
                    _viewModel.navigateToLogin();
                    SmartDialog.dismiss();
                  },
                ),
              );
            } else {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [_createTitle(_viewModel.gethomeTittle())],
                ),
              ));
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: _viewModel.getClientName(),
      ),
    ));
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

  _createPlantList() {
    return store.plantList
        .map((plant) => PlantStatsWidget(plantStats: plant))
        .toList();
  }
}
