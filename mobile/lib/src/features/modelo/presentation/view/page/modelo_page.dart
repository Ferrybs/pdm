import 'package:flutter/material.dart';

class ModeloPage extends StatefulWidget {
  const ModeloPage({Key? key}) : super(key: key);
  @override
  State<ModeloPage> createState() => _ModeloPage();
}

class _ModeloPage extends State<ModeloPage> {
  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Text("Modelo");
  }
}
