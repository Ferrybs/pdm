import 'package:basearch/src/features/home/presentation/view/page/home_chat_page.dart';
import 'package:basearch/src/features/home/presentation/view/page/home_device_page.dart';
import 'package:basearch/src/features/home/presentation/view/page/home_plant_page.dart';
import 'package:basearch/src/features/home/presentation/view/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import '../../viewmodel/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  final int idx;
  const HomePage({Key? key, required this.idx}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _viewModel = Modular.get<HomeViewModel>();
  List widgetOptions = [
    const HomeDevicePage(),
    const HomePlantPage(),
    const HomeChatPage()
  ];
  late ThemeData _theme;
  @override
  void initState() {
    super.initState();
    _viewModel.updateCurrentIndex(widget.idx);
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
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
        builder: (_) => CustomNavigationBar(
              iconSize: 25,
              selectedColor: _theme.colorScheme.primary,
              strokeColor: _theme.colorScheme.surface,
              unSelectedColor: _theme.colorScheme.secondary,
              backgroundColor: _theme.shadowColor,
              items: <CustomNavigationBarItem>[
                CustomNavigationBarItem(
                    icon: const Icon(Icons.developer_board)),
                CustomNavigationBarItem(
                  icon: const Icon(Icons.home),
                ),
                CustomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.robot),
                ),
                CustomNavigationBarItem(
                  icon: Icon(Icons.exit_to_app_outlined),
                ),
              ],
              currentIndex: _viewModel.currentIndex,
              onTap: _viewModel.updateCurrentIndex,
            ));
  }
}
