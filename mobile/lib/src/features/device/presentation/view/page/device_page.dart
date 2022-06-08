import 'package:basearch/src/features/device/presentation/view/widget/device_app_bar.dart';
import 'package:basearch/src/features/device/presentation/view/widget/device_blue_on.dart';
import 'package:basearch/src/features/device/presentation/view/widget/device_text_input.dart';
import 'package:basearch/src/features/device/presentation/viewmodel/device_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:localization/localization.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);
  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  late ThemeData _theme;
  final _viewModel = Modular.get<DeviceViewModel>();

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: const DeviceAppBar(),
      body: Column(
        children: [
          _tittle(),
          Expanded(child: Observer(
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Stepper(
                      steps: [
                        _deviceConnection(),
                        _deviceConfig(),
                        _finishConfig()
                      ],
                      currentStep: _viewModel.stepIndex,
                      onStepContinue: _onStepContinue,
                      onStepCancel: _onStepCancel,
                    )),
              );
            },
          ))
        ],
      ),
    ));
  }

  String _updateErrorName() {
    String error = '';
    setState(() {
      error = _viewModel.errorDeviceName;
    });
    return error;
  }

  _onStepCancel() async {
    _viewModel.updateStepCancel(_viewModel.stepIndex - 1);
  }

  _onStepContinue() async {
    SmartDialog.showLoading(
        msg: "loading".i18n(), background: _theme.backgroundColor);
    await _viewModel.updateStep();
    SmartDialog.dismiss();
  }

  Step _finishConfig() {
    return Step(
        title: _painelTittle("Finish Configuration"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _configStep("Step 1 ", "Connect back to your wifi."),
            _configStep("Step 2 ", "click-on".i18n() + "continue".i18n())
          ],
        ));
  }

  Step _deviceConfig() {
    return Step(
        title: _painelTittle("Wireless Configuration"),
        content: _wifiDeviceConfig(),
        state: _viewModel.wifiConfigStatus);
  }

  Step _deviceConnection() {
    return Step(
        title: _painelTittle(
          "device-connection".i18n(),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeviceTextInput(
              errorText: _viewModel.errorDeviceName,
              onChange: _viewModel.updateDeviceName,
              label: "device-name".i18n(),
            )
          ],
        ),
        state: _viewModel.deviceConfigStatus);
  }

  Padding _configStep(String step, String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              step,
              style: _theme.textTheme.bodySmall,
            ),
            Text(
              text,
              style: _theme.textTheme.bodySmall,
            )
          ]),
    );
  }

  Column _wifiDeviceConfig() {
    return Column(
      children: [
        DeviceTextInput(
          errorText: _viewModel.errorWifi,
          prefixIcon: const Icon(Icons.wifi),
          label: "wireless-SSID".i18n(),
          onChange: _viewModel.updateSSID,
        ),
        DeviceTextInput(
          errorText: _viewModel.errorWifi,
          prefixIcon: const Icon(Icons.wifi),
          label: "wireless-password".i18n(),
          onChange: _viewModel.updatePassword,
        ),
      ],
    );
  }

  Padding _painelTittle(String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: _theme.textTheme.titleMedium,
      ),
    );
  }

  Padding _tittle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          "new-plant-tittle".i18n(),
          style: _theme.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
