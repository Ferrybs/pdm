import 'package:basearch/components/hud/modal_progress_hud.dart';
import 'package:basearch/src/features/auth/presentation/view/widget/text_field_login.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _viewModel = Modular.get<LoginViewModel>();
  late ThemeData _theme;
  String? emailError;
  String? passwordError;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              _logo(),
              _login(context),
              _signIn(),
              TextInputAuth(
                errorText: emailError,
                onChange: (value) {
                  _viewModel.updateEmail(value);
                },
                label: 'email'.i18n(),
                prefixIcon: const Icon(
                  IconData(0xe780, fontFamily: 'MaterialIcons'),
                ),
              ),
              TextInputAuth(
                  errorText: passwordError,
                  onChange: (value) {
                    _viewModel.updatePassword(value);
                  },
                  prefixIcon: const Icon(
                    IconData(0xeb71, fontFamily: 'MaterialIcons'),
                  ),
                  obscureText: true,
                  label: 'password'.i18n()),
              _button(_getClient, Text('login'.i18n().toUpperCase())),
              Center(
                child: TextButton(
                  child: Text('forgot-pass'.i18n()),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 25),
              _row(_theme)
            ]),
          ),
        ),
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

  void _getClient() async {
    setState(() {
      emailError = _viewModel.emailValidation();
      passwordError = _viewModel.passwordValidation();
    });

    if (emailError == null) {
      setState(() {
        showSpinner = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        showSpinner = false;
      });
    }
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

  Padding _login(BuildContext context) {
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
