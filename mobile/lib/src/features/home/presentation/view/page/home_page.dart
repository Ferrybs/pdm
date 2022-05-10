import 'package:basearch/src/features/home/presentation/view/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
                child: Text(
                  '${snapshot.error} occured',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data as String;
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [_createTitle(data)],
                ),
              ));
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getData(),
      ),
    ));
  }

  Future<String> getData() {
    return _viewModel.gethomeTittle();
  }

  // @override
  // Widget build(BuildContext context) {
  //   _theme = Theme.of(context);
  //   return Scaffold(
  //     appBar: const HomeAppBar(),
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(18.0),
  //         child: Column(
  //           children: [
  //             _createTitle(),
  //             ..._createPlantList(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
