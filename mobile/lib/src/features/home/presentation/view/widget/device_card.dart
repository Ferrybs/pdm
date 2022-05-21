import 'package:basearch/src/features/home/domain/model/device_model.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({Key? key, required this.deviceCardModel}) : super(key: key);
  final DeviceModel deviceCardModel;
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Card(
        child: InkWell(
      onTap: (() {}),
      child: SizedBox(
        width: 200,
        height: 100,
        child: Text(
          deviceCardModel.name,
          style: _theme.textTheme.headlineSmall,
        ),
      ),
    ));
  }
}
