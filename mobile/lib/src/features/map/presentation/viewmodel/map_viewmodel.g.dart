// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapViewModel on _MapViewModelBase, Store {
  late final _$deviceListAtom =
      Atom(name: '_MapViewModelBase.deviceList', context: context);

  @override
  ObservableList<String> get deviceList {
    _$deviceListAtom.reportRead();
    return super.deviceList;
  }

  @override
  set deviceList(ObservableList<String> value) {
    _$deviceListAtom.reportWrite(value, super.deviceList, () {
      super.deviceList = value;
    });
  }

  late final _$markersAtom =
      Atom(name: '_MapViewModelBase.markers', context: context);

  @override
  ObservableSet<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(ObservableSet<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_MapViewModelBase.position', context: context);

  @override
  LatLng get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(LatLng value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

<<<<<<< HEAD
  late final _$mapControllerAtom =
      Atom(name: '_MapViewModelBase.mapController', context: context);

  @override
  GoogleMapController get mapController {
    _$mapControllerAtom.reportRead();
    return super.mapController;
  }

  @override
  set mapController(GoogleMapController value) {
    _$mapControllerAtom.reportWrite(value, super.mapController, () {
      super.mapController = value;
    });
  }

=======
>>>>>>> feature/home-plant
  late final _$loadErrorAtom =
      Atom(name: '_MapViewModelBase.loadError', context: context);

  @override
  String? get loadError {
    _$loadErrorAtom.reportRead();
    return super.loadError;
  }

  @override
  set loadError(String? value) {
    _$loadErrorAtom.reportWrite(value, super.loadError, () {
      super.loadError = value;
    });
  }

  late final _$sliderAtom =
      Atom(name: '_MapViewModelBase.slider', context: context);

  @override
  double get slider {
    _$sliderAtom.reportRead();
    return super.slider;
  }

  @override
  set slider(double value) {
    _$sliderAtom.reportWrite(value, super.slider, () {
      super.slider = value;
    });
  }

  late final _$selectedValueAtom =
      Atom(name: '_MapViewModelBase.selectedValue', context: context);

  @override
  String? get selectedValue {
    _$selectedValueAtom.reportRead();
    return super.selectedValue;
  }

  @override
  set selectedValue(String? value) {
    _$selectedValueAtom.reportWrite(value, super.selectedValue, () {
      super.selectedValue = value;
    });
  }

  late final _$_MapViewModelBaseActionController =
      ActionController(name: '_MapViewModelBase', context: context);

  @override
  dynamic updateCurrentSlider(double value) {
    final _$actionInfo = _$_MapViewModelBaseActionController.startAction(
        name: '_MapViewModelBase.updateCurrentSlider');
    try {
      return super.updateCurrentSlider(value);
    } finally {
      _$_MapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updatePosition(LatLng value) {
    final _$actionInfo = _$_MapViewModelBaseActionController.startAction(
        name: '_MapViewModelBase.updatePosition');
    try {
      return super.updatePosition(value);
    } finally {
      _$_MapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
<<<<<<< HEAD
  dynamic updateController(GoogleMapController value) {
    final _$actionInfo = _$_MapViewModelBaseActionController.startAction(
        name: '_MapViewModelBase.updateController');
    try {
      return super.updateController(value);
    } finally {
      _$_MapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
=======
>>>>>>> feature/home-plant
  dynamic updadeDeviceList(ObservableList<String> device) {
    final _$actionInfo = _$_MapViewModelBaseActionController.startAction(
        name: '_MapViewModelBase.updadeDeviceList');
    try {
      return super.updadeDeviceList(device);
    } finally {
      _$_MapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updadeMarkerList(Set<Marker> marks) {
    final _$actionInfo = _$_MapViewModelBaseActionController.startAction(
        name: '_MapViewModelBase.updadeMarkerList');
    try {
      return super.updadeMarkerList(marks);
    } finally {
      _$_MapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateLoadError(String? vaule) {
    final _$actionInfo = _$_MapViewModelBaseActionController.startAction(
        name: '_MapViewModelBase.updateLoadError');
    try {
      return super.updateLoadError(vaule);
    } finally {
      _$_MapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateSelectedValue(String? vaule) {
    final _$actionInfo = _$_MapViewModelBaseActionController.startAction(
        name: '_MapViewModelBase.updateSelectedValue');
    try {
      return super.updateSelectedValue(vaule);
    } finally {
      _$_MapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
deviceList: ${deviceList},
markers: ${markers},
position: ${position},
<<<<<<< HEAD
mapController: ${mapController},
=======
>>>>>>> feature/home-plant
loadError: ${loadError},
slider: ${slider},
selectedValue: ${selectedValue}
    ''';
  }
}
