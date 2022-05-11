import 'package:basearch/src/features/auth/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/auth/presentation/view/widget/text_field_login.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:localization/localization.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);
  @override
  State<CreateAccount> createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  final _viewModel = Modular.get<AuthViewModel>();
  bool showSpinner = false;
  late ThemeData _theme;
  String? nameError;
  String? lastNameError;
  String? emailError;
  String? passwordError;
  String? passwordMatchError;
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
          _createAccount(),
          _commumSubtittle(),
          TextInputAuth(
              errorText: nameError,
              label: 'name'.i18n(),
              prefixIcon: const Icon(
                IconData(0xf0071, fontFamily: 'MaterialIcons'),
              ),
              onChange: _viewModel.updateName),
          TextInputAuth(
              errorText: lastNameError,
              label: 'last-name'.i18n(),
              prefixIcon: const Icon(
                IconData(0xf0071, fontFamily: 'MaterialIcons'),
              ),
              onChange: _viewModel.updateLastName),
          TextInputAuth(
            errorText: emailError,
            label: 'E-mail',
            obscureText: false,
            prefixIcon: const Icon(
              IconData(0xe780, fontFamily: 'MaterialIcons'),
            ),
            onChange: _viewModel.updateEmail,
          ),
          TextInputAuth(
            errorText: passwordError,
            label: 'password'.i18n(),
            obscureText: true,
            prefixIcon: const Icon(
              IconData(0xeb71, fontFamily: 'MaterialIcons'),
            ),
            onChange: _viewModel.updatePassword,
          ),
          TextInputAuth(
            errorText: passwordMatchError,
            label: 'confirm-password'.i18n(),
            obscureText: true,
            prefixIcon: const Icon(
              IconData(0xeb71, fontFamily: 'MaterialIcons'),
            ),
            onChange: _viewModel.updateConfirmPassword,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                child: Text('sign-up'.i18n().toUpperCase()),
                onPressed: _signUp,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(
                builder: (context) => Text(
                  'have-account'.i18n(),
                  style: _theme.textTheme.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: () => Modular.to.pop(),
                child: Text('sign-in'.i18n()),
              )
            ],
          ),
        ],
      )),
    );
  }

  void _signUp() async {
    String? result;
    _setFieldsState();
    if (_viewModel.signUpValidation()) {
      result = await _register();
      if (result == null) {
        _dialog("create-account-success".i18n(), "continue".i18n(),
            _viewModel.navigateTOLoginPage);
      } else {
        _dialog(result, "try-agin".i18n(), null);
      }
    }
  }

  Future<String?> _register() async {
    SmartDialog.showLoading(
        msg: "loading".i18n(), background: _theme.backgroundColor);
    var result = await _viewModel.register();
    SmartDialog.dismiss();
    return result;
  }

  void _dialog(String message, String buttonText, Function? fn) {
    SmartDialog.show(
        widget: DialogContainer(
      message: message,
      buttonText: buttonText,
      onClick: () {
        if (fn != null) {
          fn();
        }
        SmartDialog.dismiss();
      },
    ));
  }

  void _setFieldsState() {
    setState(() {
      nameError = _viewModel.nameValidation();
      lastNameError = _viewModel.lastNameValidation();
      emailError = _viewModel.emailValidation();
      passwordError = _viewModel.passwordValidation();
      passwordMatchError = _viewModel.passwordMatchValidation();
    });
  }

  Padding _commumSubtittle() {
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

  Padding _createAccount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Builder(
        builder: (context) => Text(
          'create-account'.i18n(),
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
