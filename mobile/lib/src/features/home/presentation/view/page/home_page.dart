import 'package:basearch/src/features/home/presentation/view/page/home_device_page.dart';
import 'package:basearch/src/features/home/presentation/view/page/home_plant_page.dart';
import 'package:basearch/src/features/home/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/home/presentation/view/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';

import '../../viewmodel/home_viewmodel.dart';
import '../widget/plant_stats_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _viewModel = Modular.get<HomeViewModel>();
  List widgetOptions = [
    const HomeDevicePage(),
    const HomePlantPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: HomeAppBar(onCloudPressed: _viewModel.navigateToMap),
      body: Observer(
          builder: (_) => widgetOptions.elementAt(_viewModel.currentIndex)),
      bottomNavigationBar: _bottomNavigationBar(),
    ));
  }

  _bottomNavigationBar() {
    return Observer(
        builder: (_) => BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.developer_board),
                  label: 'Device',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.robot),
                  label: 'Help',
                ),
              ],
              currentIndex: _viewModel.currentIndex,
              onTap: _viewModel.updateCurrentIndex,
            ));
  }
}
