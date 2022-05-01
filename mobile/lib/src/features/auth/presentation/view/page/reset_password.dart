import 'package:basearch/src/features/auth/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/auth/presentation/view/widget/text_field_login.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:localization/localization.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPassord();
}

class _ResetPassord extends State<ResetPassword> {
  final _viewModel = Modular.get<LoginViewModel>();
  late ThemeData _theme;
  String? emailError;
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: _goBackButton(context),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _recovery(),
          _subtittle(),
          TextInputAuth(
            errorText: emailError,
            label: 'email'.i18n(),
            prefixIcon: const Icon(
              IconData(0xf0071, fontFamily: 'MaterialIcons'),
            ),
            onChange: (value) {
              _viewModel.updateEmail(value);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                child: Text('reset'.i18n().toUpperCase()),
                onPressed: _reset,
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _reset() async {
    _validateFields();
    if (_viewModel.resetPasswordValidation()) {
      var result = await _sendReset();
      if (result) {
        _dialog("email-send-success".i18n(), "continue".i18n(), "/");
      } else {
        _dialog("create-account-failed".i18n(), "try-agin".i18n(), null);
      }
    }
  }

  void _dialog(String message, String buttonText, String? path) {
    SmartDialog.show(
        widget: DialogContainer(
      message: message,
      buttonText: buttonText,
      onClick: () {
        if (path != null) {
          Modular.to.navigate(path);
        }
        SmartDialog.dismiss();
      },
    ));
  }

  Future<bool> _sendReset() async {
    SmartDialog.showLoading(background: _theme.backgroundColor);
    var result = await _viewModel.resetPassword();
    SmartDialog.dismiss();
    return result;
  }

  void _validateFields() {
    setState(() {
      emailError = _viewModel.emailValidation();
    });
  }

  Padding _subtittle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Builder(
        builder: (context) => Text(
          'fill-input'.i18n(),
          style: _theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  Padding _recovery() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Builder(
        builder: (context) => Text(
          'reset-password'.i18n(),
          style: _theme.textTheme.titleLarge,
        ),
      ),
    );
  }
}

Widget _goBackButton(BuildContext context) {
  return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Modular.to.navigate('/');
      });
}
