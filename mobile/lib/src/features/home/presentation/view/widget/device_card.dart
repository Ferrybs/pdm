import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({Key? key, required this.deviceDTO}) : super(key: key);
  final DeviceDTO deviceDTO;
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Center(
        child: Card(
      elevation: 5,
      child: ExpansionTile(
        leading: const CircleAvatar(
          child: Icon(Icons.developer_board),
        ),
        title: Text(
          deviceDTO.name,
          style: _theme.textTheme.bodyLarge,
        ),
        subtitle: Text(
          "id: " + deviceDTO.id,
          style: _theme.textTheme.bodySmall,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                splashRadius: 18,
                color: _theme.colorScheme.secondary,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                splashRadius: 18,
                color: _theme.colorScheme.error,
              )
            ],
          )
        ],
      ),
    ));
  }
}
