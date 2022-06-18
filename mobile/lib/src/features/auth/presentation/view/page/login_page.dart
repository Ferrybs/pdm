import 'package:basearch/src/features/auth/presentation/view/widget/dialog_container.dart';
import 'package:basearch/src/features/auth/presentation/view/widget/text_field_login.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _viewModel = Modular.get<AuthViewModel>();
  late ThemeData _theme;
  String? emailError;
  String? passwordError;
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return SafeArea(
        child: Observer(
      builder: (_) => FutureBuilder(
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (_viewModel.hasToken) {
                _viewModel.navigateToHomePage();
              } else {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(children: [
                      _logo(),
                      _loginText(context),
                      _signIn(),
                      _emailInput(),
                      _passwordInput(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                            child: Observer(
                              builder: ((context) => Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      _getColor),
                                  value: _viewModel.isRefreshToken,
                                  onChanged: _viewModel.changeRefresh)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: Text("remember-me".i18n()),
                          )
                        ],
                      ),
                      _button(_login, Text('login'.i18n().toUpperCase())),
                      _forgotPassword(),
                      const SizedBox(height: 25),
                      _row(_theme)
                    ]),
                  ),
                );
              }
            }
            return Center(
                child: CircularProgressIndicator(
              color: _theme.colorScheme.primary,
            ));
          }),
          future: _viewModel.loadData()),
    ));
  }

  Color? _getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return _theme.backgroundColor;
    }
    return _theme.backgroundColor;
  }

  Center _forgotPassword() {
    return Center(
      child: TextButton(
        child: Text('forgot-password'.i18n()),
        onPressed: () => Modular.to.pushNamed('/auth/reset-password'),
      ),
    );
  }

  TextInputAuth _passwordInput() {
    return TextInputAuth(
        errorText: passwordError,
        onChange: (value) {
          _viewModel.updatePassword(value);
        },
        prefixIcon: const Icon(
          IconData(0xeb71, fontFamily: 'MaterialIcons'),
        ),
        obscureText: true,
        label: 'password'.i18n());
  }

  TextInputAuth _emailInput() {
    return TextInputAuth(
      errorText: emailError,
      onChange: (value) {
        _viewModel.updateEmail(value);
      },
      label: 'email'.i18n(),
      prefixIcon: const Icon(
        IconData(0xe780, fontFamily: 'MaterialIcons'),
      ),
    );
  }

  Row _row(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'no-account'.i18n(),
          style: theme.textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () => Modular.to.pushNamed('/auth/signup'),
          child: Text('sign-up'.i18n()),
        ),
      ],
    );
  }

  Padding _button(Function get, Widget txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ElevatedButton(
          child: txt,
          onPressed: () => get(),
        ),
      ),
    );
  }

  void _login() async {
    _validateFields();
    if (_viewModel.signInValidation()) {
      var result = await _doLogin();
      if (result != null) {
        _dialog(result, "try-again".i18n());
      }
    }
  }

  void _dialog(String message, String buttonText) {
    SmartDialog.show(
        widget: DialogContainer(
      message: message,
      buttonText: buttonText,
      onClick: () {
        SmartDialog.dismiss();
      },
    ));
  }

  Future<String?> _doLogin() async {
    SmartDialog.showLoading(
        msg: "loading".i18n(), background: _theme.backgroundColor);
    var result = await _viewModel.login();
    SmartDialog.dismiss();
    return result;
  }

  void _validateFields() {
    setState(() {
      emailError = _viewModel.emailValidation();
      passwordError = _viewModel.passwordValidation();
    });
  }

  Padding _signIn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Builder(
        builder: (context) => Text(
          'signin'.i18n(),
          style: _theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  Padding _loginText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
      child: Text(
        'login'.i18n(),
        style: _theme.textTheme.titleLarge,
      ),
    );
  }

  Center _logo() {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: SvgPicture.asset('lib/assets/images/v968-10-ps.svg'),
      ),
    );
  }
}
