import 'package:basearch/src/features/map/data/dto/device_dto.dart';
import 'package:basearch/src/features/map/domain/model/device_model.dart';
import 'package:basearch/src/features/map/domain/usecase/map_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';

part 'map_viewmodel.g.dart';

class MapViewModel = _MapViewModelBase with _$MapViewModel;

abstract class _MapViewModelBase with Store {
  final _usecase = Modular.get<MapUsecase>();

  @observable
  ObservableList<String> deviceList = ObservableList();

  @observable
  ObservableSet<Set<Marker>> markers = ObservableSet.of([]);

  @observable
  BitmapDescriptor? icon;

  @observable
  String? loadError;

  @observable
  String? selectedValue;

  @action
  updadeDeviceList(ObservableList<String> device) {
    deviceList = device;
  }

  @action
  updateLoadError(String? vaule) {
    loadError = vaule;
  }

  @action
  updateSelectedValue(String? vaule) {
    selectedValue = vaule;
  }

  String getMapTitle() {
    return "map-title".i18n();
  }

  void navigateToHome() {
    Modular.to.navigate('/home/');
  }

  Future<void> loadPage() async {
    icon = await _usecase.loadIcon();
    List<DeviceDTO>? devices = await _usecase.getDevices();
    if (devices != null) {
      //updateSelectedValue(devices.first.name);
      updadeDeviceList(devices.map((e) => e.name).toList().asObservable());
    }
  }
}
