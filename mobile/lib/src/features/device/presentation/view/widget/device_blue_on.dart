import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceBlueOn extends StatelessWidget {
  const DeviceBlueOn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          StreamBuilder<Future<List<BluetoothDevice>>>(
              stream: Stream.periodic(const Duration(seconds: 2)).map(
                  (_) async => await FlutterBluePlus.instance.connectedDevices),
              builder: (c, snapshot) => FutureBuilder<List<ListTile>>(
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!,
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
                    future: _transformDeviceList(snapshot.data),
                  ))
        ])),
        onRefresh: () => FlutterBluePlus.instance
            .startScan(timeout: const Duration(seconds: 4)));
  }

  Future<List<ListTile>> _transformDeviceList(
      Future<List<BluetoothDevice>>? data) async {
    return await data!.then((value) => value
        .map((d) => ListTile(
              title: Text(d.name),
              subtitle: Text(d.id.toString()),
              trailing: StreamBuilder<BluetoothDeviceState>(
                stream: d.state,
                initialData: BluetoothDeviceState.disconnected,
                builder: (c, snapshot) {
                  if (snapshot.data == BluetoothDeviceState.connected) {
                    return ElevatedButton(
                      child: const Text('OPEN'),
                      onPressed: () {},
                    );
                  }
                  return Text(snapshot.data.toString());
                },
              ),
            ))
        .toList());
  }
}
