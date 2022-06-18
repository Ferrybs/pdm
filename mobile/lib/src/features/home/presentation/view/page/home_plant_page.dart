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
            children: [_createTitle(_viewModel.gethomeTittle()), _plantCards()],
          ),
        ),
      ),
    );
  }

  ListView _plantCards() {
    return ListView.builder(
      itemCount: _viewModel.devicelist.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return PlantCard(deviceDTO: _viewModel.devicelist[index]);
      },
    );
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
