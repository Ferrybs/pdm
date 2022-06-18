import 'dart:typed_data';

import 'package:basearch/src/features/map/data/dto/device_dto.dart';
import 'package:basearch/src/features/map/data/dto/device_localization_dto.dart';
import 'package:basearch/src/features/map/data/dto/localization_dto.dart';
import 'package:basearch/src/features/map/domain/model/device_map_model.dart';
import 'package:basearch/src/features/map/domain/model/device_model.dart';
import 'package:basearch/src/features/map/domain/model/map_device_query_model.dart';
import 'package:basearch/src/features/map/domain/model/map_localization_model.dart';
import 'package:basearch/src/features/map/presentation/view/widget/map_info_dialog_container.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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

  Future<DeviceLocalizationDTO?> getDeviceLocalization(
      String deviceName) async {
    String? token = await _preference.getAccessToken();
    List<DeviceDTO>? devicesDTO = await getDevices();

    if (devicesDTO != null) {
      DeviceDTO device = devicesDTO
          .where((element) => element.name.contains(deviceName))
          .first;
      MapLocalizationModel localization =
          await _repository.getDeviceLocalization(token ?? "", device.id);
      return DeviceLocalizationDTO(
          deviceDTO: device,
          localizationDTO: LocalizationDTO(
              latitude: localization.latitude,
              longitude: localization.longitde));
    }
    return null;
  }

  Future<Set<Marker>?> search(
      double distance, LocalizationDTO localization, deviceId) async {
    try {
      String? token = await _preference.getAccessToken();
      List<DeviceMapModel> devicesMap = await _repository.getMapDevices(
          token ?? "",
          MapDeviceQueryModel(
              id: deviceId,
              latitude: localization.latitude,
              longitude: localization.longitude,
              distance: distance.toInt()));
      return await _toMarks(devicesMap);
    } catch (e) {
      return null;
    }
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

  Future<Set<Marker>> getMarks(List<DeviceDTO> devices) async {
    Set<Marker> markers = {};
    try {
      String? token = await _preference.getAccessToken();
      MapLocalizationModel localization = await _repository
          .getDeviceLocalization(token ?? ' ', devices.first.id);
      MapDeviceQueryModel query = MapDeviceQueryModel(
          id: devices.first.id,
          latitude: localization.latitude,
          longitude: localization.longitde,
          distance: 1);
      List<DeviceMapModel> decivesMap =
          await _repository.getMapDevices(token ?? ' ', query);

      return await _toMarks(decivesMap);
    } catch (e) {
      return markers;
    }
  }

  Future<Set<Marker>> _toMarks(List<DeviceMapModel> decivesMap) async {
    Set<Marker> markers = {};
    for (var element in decivesMap) {
      Marker marker = Marker(
          onTap: (() => _dialog(element)),
          markerId: MarkerId(element.id),
          icon: await loadIcon(),
          position: LatLng(
              element.localization.latitude, element.localization.longitde));
      markers.add(marker);
    }
    return markers;
  }

  _dialog(DeviceMapModel deviceMap) {
    SmartDialog.show(
        widget: MapInfoDialog(
      tittle: "preferences".i18n(),
      temperature: deviceMap.preferences.temperature,
      humidity: deviceMap.preferences.humidity,
      luminosity: deviceMap.preferences.luminosity,
      moisture: deviceMap.preferences.moisture,
      onCancelText: "cancel".i18n(),
      onCancel: () {
        SmartDialog.dismiss();
      },
    ));
  }
}
