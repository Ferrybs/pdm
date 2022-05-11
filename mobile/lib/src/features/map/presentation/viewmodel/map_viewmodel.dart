import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';

part 'map_viewmodel.g.dart';

class MapViewModel = _MapViewModelBase with _$MapViewModel;

abstract class _MapViewModelBase with Store {
  String getMapTitle() {
    return "map-title".i18n();
  }

  void navigateToHome() {
    Modular.to.navigate('/home/');
  }
}
