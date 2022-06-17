import 'package:basearch/src/features/map/presentation/view/widget/map_dialog_container.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late double lat;
  late double long;
  late ThemeData _theme;

  final _viewModel = Modular.get<MapViewModel>();

  late final LatLng _position =
      const LatLng(-15.842278224686755, -48.02358141956272);

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Observer(builder: (context) {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_viewModel.loadError != null) {
              return Container(
                color: _theme.colorScheme.background,
                child: MapDialogContainer(
                  message:
                      _viewModel.loadError ?? "session-error-tittle".i18n(),
                  buttonText: "try-again".i18n(),
                  onClick: () {
                    _viewModel.navigateToHome();
                  },
                ),
              );
            }
            {
              return _body();
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: _viewModel.loadPage(),
      );
    });
  }

  SafeArea _body() {
    return SafeArea(
        child: Stack(
      children: [
        Observer(builder: (context) {
          return GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _position,
              zoom: 14.0,
            ),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
          );
        }),
        _appBar(),
        Align(
          alignment: Alignment.bottomCenter,
          child: _bottomBar(),
        )
      ],
    ));
  }

  ClipRRect _bottomBar() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      child: Container(
        height: 120,
        color: _theme.cardColor,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(22, 10, 0, 5),
                  child: Text(
                    "search-distance".i18n(),
                    style: _theme.textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 11, 0, 5),
                  child: Text(
                    "100 Km",
                    style: _theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 5, 12, 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: _theme.backgroundColor),
                  child: _slider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _slider() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
              child: Slider(
                value: 0,
                max: 100,
                divisions: 2,
                onChanged: (double vaule) {},
              )),
        )
      ],
    );
  }

  Padding _appBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 20, 12, 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: _theme.backgroundColor,
          ),
          child: _barItems(),
        ),
      ),
    );
  }

  Row _barItems() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: IconButton(
                  color: _theme.colorScheme.secondary,
                  onPressed: _viewModel.navigateToHome,
                  icon: Icon(Icons.arrow_back)),
            )),
        Expanded(
          flex: 8,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: CustomDropdownButton2(
                icon: Icon(Icons.developer_board),
                iconSize: 22,
                iconEnabledColor: _theme.colorScheme.secondary,
                hint: "select-device-name".i18n(),
                buttonWidth: 400,
                value: null,
                dropdownItems: ["Intem 1", "Item 2"],
                onChanged: (String? tipo) {}),
          ),
        )
      ],
    );
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
}
