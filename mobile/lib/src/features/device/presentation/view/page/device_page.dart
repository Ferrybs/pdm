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
    return Text("Device");
  }
}
