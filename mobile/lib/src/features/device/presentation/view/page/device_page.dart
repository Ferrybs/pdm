import 'package:basearch/src/features/device/presentation/view/widget/device_app_bar.dart';
import 'package:flutter/material.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);
  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: DeviceAppBar(),
      body: Column(
        children: [],
      ),
    ));
  }
}
