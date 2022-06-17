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
  ObservableSet<Set<Marker>> markers = ObservableSet.of([]);

  @observable
  BitmapDescriptor? icon;

  @observable
  String? loadError;

  String getMapTitle() {
    return "map-title".i18n();
  }

  void navigateToHome() {
    Modular.to.navigate('/home/');
  }

  loadPage() async {
    icon = await _usecase.loadIcon();
  }
}
