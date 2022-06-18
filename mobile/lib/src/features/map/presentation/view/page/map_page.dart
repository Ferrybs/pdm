import 'package:basearch/src/features/map/presentation/view/widget/map_dialog_container.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';

import '../../viewmodel/map_viewmodel.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late ThemeData _theme;
  late Future<Set<Marker>> result;

  final _viewModel = Modular.get<MapViewModel>();

  @override
  void initState() {
    super.initState();
    result = _viewModel.loadPage();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Observer(builder: (context) {
      return FutureBuilder<Set<Marker>>(
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
              return Observer(builder: (context) {
                return _body();
              });
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: result,
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
              target: _viewModel.position,
              zoom: 14.0,
            ),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            markers: _viewModel.markers,
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
                Observer(builder: (context) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10, 11, 0, 5),
                    child: Text(
                      _viewModel.slider.toString() + " Km",
                      style: _theme.textTheme.titleMedium,
                    ),
                  );
                }),
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

  Observer _slider() {
    return Observer(builder: (context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Observer(builder: (context) {
                  return Slider(
                    value: _viewModel.slider,
                    min: 1,
                    max: 100,
                    divisions: 50,
                    onChanged: ((double value) {
                      setState(() {});
                      _viewModel.updateCurrentSlider(value.floorToDouble());
                    }),
                    onChangeEnd: (double value) {
                      _doSearch();
                    },
                  );
                })),
          )
        ],
      );
    });
  }

  _doSearch() async {
    SmartDialog.showLoading(
        msg: "loading".i18n(), background: _theme.backgroundColor);
    await _viewModel.search(mapController);
    setState(() {
      _viewModel.markers;
    });
    SmartDialog.dismiss();
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
            child: Observer(builder: (context) {
              return CustomDropdownButton2(
                  icon: Icon(Icons.developer_board),
                  iconSize: 22,
                  iconEnabledColor: _theme.colorScheme.secondary,
                  hint: "select-device-name".i18n(),
                  itemPadding: EdgeInsets.only(left: 20),
                  value: _viewModel.selectedValue,
                  dropdownItems: _viewModel.deviceList,
                  onChanged: (value) {
                    _viewModel.updateSelectedValue(value);
                    setState(() {});
                    _doSearch();
                  });
            }),
          ),
        )
      ],
    );
  }

  _newPositon(LatLng position) {
    mapController.animateCamera(CameraUpdate.newLatLng(position));
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await _viewModel.onMapCreated();
    String style = await DefaultAssetBundle.of(context)
        .loadString('lib/assets/styles/map_style.json');
    mapController.setMapStyle(style);
    _newPositon(_viewModel.position);
  }
}
