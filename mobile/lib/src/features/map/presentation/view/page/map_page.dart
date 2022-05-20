import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localization/localization.dart';

import '../../viewmodel/map_viewmodel.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ModularState<MapPage, MapViewModel> {
  late GoogleMapController mapController;
  late double lat;
  late double long;
  late ThemeData _theme;

  final _viewModel = Modular.get<MapViewModel>();

  late final LatLng _position = const LatLng(-15.8306559, -47.9264053);

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: _createTitle(_viewModel.getMapTitle()),
          actions: [_createAction()]),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _position,
            zoom: 11.0,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
        ),
      ),
    ));
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    getPosition();

    String style = await DefaultAssetBundle.of(context)
        .loadString('lib/assets/styles/map_style.json');

    mapController.setMapStyle(style);
  }

  Future<Position> _currentPosition() async {
    LocationPermission permission;
    bool isEnabled;

    isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      await Geolocator.openLocationSettings();

      isEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getPosition() async {
    try {
      final position = await _currentPosition();
      lat = position.latitude;
      long = position.longitude;

      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _createTitle(String tittle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        tittle,
        style: _theme.textTheme.headlineMedium,
      ),
    );
  }

  _createAction() {
    return IconButton(
      icon: const Icon(Icons.home),
      onPressed: () => {_viewModel.navigateToHome()},
    );
  }
}
