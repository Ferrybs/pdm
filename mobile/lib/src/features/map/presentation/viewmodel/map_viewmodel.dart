import 'package:basearch/src/features/map/data/dto/device_dto.dart';
import 'package:basearch/src/features/map/data/dto/device_localization_dto.dart';
import 'package:basearch/src/features/map/data/dto/localization_dto.dart';
import 'package:basearch/src/features/map/domain/model/device_model.dart';
import 'package:basearch/src/features/map/domain/usecase/map_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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
  ObservableSet<Marker> markers = ObservableSet.of([]);

  @observable
  LatLng position = LatLng(0, 0);

  @observable
  late GoogleMapController mapController;

  @observable
  String? loadError;

  @observable
  double slider = 1;

  @observable
  String? selectedValue;

  @action
  updateCurrentSlider(double value) {
    slider = value;
  }

  @action
  updatePosition(LatLng value) {
    position = value;
  }

  @action
  updateController(GoogleMapController value) {
    mapController = value;
  }

  @action
  updadeDeviceList(ObservableList<String> device) {
    deviceList = device;
  }

  @action
  updadeMarkerList(Set<Marker> marks) {
    markers = ObservableSet.of(marks);
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

  Future<void> onMapCreated(GoogleMapController controller) async {
    updateController(controller);
    DeviceLocalizationDTO? deviceLoc =
        await _usecase.getDeviceLocalization(selectedValue ?? '');
    if (deviceLoc != null) {
      updatePosition(LatLng(deviceLoc.localizationDTO.latitude,
          deviceLoc.localizationDTO.longitude));
    }
  }

  search() async {
    DeviceLocalizationDTO? deviceLocalizationDTO =
        await _usecase.getDeviceLocalization(selectedValue ?? '');
    if (deviceLocalizationDTO != null) {
      Set<Marker> markers = await _usecase.search(
              slider,
              deviceLocalizationDTO.localizationDTO,
              deviceLocalizationDTO.deviceDTO.id) ??
          {};
      updadeMarkerList(markers);
      if (markers.isNotEmpty) {
        updatePosition(LatLng(deviceLocalizationDTO.localizationDTO.latitude,
            deviceLocalizationDTO.localizationDTO.longitude));
        mapController.animateCamera(CameraUpdate.newLatLng(position));
      }
    }
  }

  Future<Set<Marker>> loadPage() async {
    Set<Marker> markersLoad = {};
    List<DeviceDTO>? devices = await _usecase.getDevices();
    if (devices != null) {
      //updateSelectedValue(devices.first.name);
      if (devices.isNotEmpty) {
        updadeMarkerList(await _usecase.getMarks(devices));
        updadeDeviceList(devices.map((e) => e.name).toList().asObservable());
      } else {
        updateLoadError("no-device-error".i18n());
      }
    } else {
      updateLoadError("session-error-tittle".i18n());
    }
    markersLoad = markers;
    return markersLoad;
  }
}
