import 'package:basearch/src/features/auth/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/auth/presentation/view/widget/text_field_login.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:basearch/src/Theme/theme.dart';
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
  final _viewModel = Modular.get<LoginViewModel>();
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
    var result = true;
    var dimiss = false;
    _setFieldsState();
    //result = await _viewModel.register();
    if (result) {
      SmartDialog.show(
          widget: DialogContainer(
            message: "Usuario Ja Cadastrado!",
            buttonText: "Login",
            onClick: () {
              Modular.to.navigate('/');
              SmartDialog.dismiss();
            },
            height: 120,
          ),
          onDismiss: () {
            Modular.to.navigate('/');
          },
          isLoadingTemp: false);
    }
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
