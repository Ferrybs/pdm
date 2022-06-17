import 'dart:typed_data';

import 'package:basearch/src/features/map/data/dto/device_dto.dart';
import 'package:basearch/src/features/map/domain/model/device_map_model.dart';
import 'package:basearch/src/features/map/domain/model/device_model.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import '../repository/map_interface.dart';

class MapUsecase {
  final _repository = Modular.get<Imap>();
  final _preference = Modular.get<PreferenceUsecase>();

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> loadIcon() async {
    final Uint8List markerIcon =
        await _getBytesFromAsset('lib/assets/images/leaf.png', 80);
    return BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<List<DeviceDTO>?> getDevices() async {
    try {
      String? token = await _preference.getAccessToken();
      List<DeviceModel> devices = await _repository.getDevices(token ?? ' ');
      return devices.map((e) => DeviceDTO(id: e.id, name: e.name)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<Set<Marker>?> getMarks() async {
    Set<Marker> markers = {};
    List<DeviceDTO>? devices = await getDevices();
    if (devices != null) {
      for (var element in devices) {
        Marker marker =
            Marker(markerId: MarkerId(element.id), icon: await loadIcon());
      }
    }
  }
}
