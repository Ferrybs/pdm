import 'package:basearch/components/hud/modal_progress_hud.dart';
import 'package:basearch/src/features/auth/data/dto/client_dto.dart';
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
              const TextInputAuth(
                label: 'E-mail',
                obscureText: false,
                prefixIcon: Icon(
                  IconData(0xe780, fontFamily: 'MaterialIcons'),
                ),
              ),
              TextInputAuth(
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
      showSpinner = true;
    });
    final client = await _viewModel.login();
    if (client != null) {
      setState(() {
        showSpinner = false;
      });
      Modular.to.navigate('/auth/success');
    }
  }

  Container _fieldSecret(BuildContext context, Widget txt) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          txt,
          const SizedBox(height: 10),
          TextField(
            style: _theme.textTheme.titleMedium
                ?.copyWith(color: _theme.textSelectionTheme.cursorColor),
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                IconData(0xeb71, fontFamily: 'MaterialIcons'),
              ),
            ),
            onChanged: (value) {
              _viewModel.updatePassword(value);
            },
          ),
        ],
      ),
    );
  }

  Container _fieldCommum(Widget txt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          txt,
          const SizedBox(height: 10),
          Builder(
            builder: (context) => TextField(
              style: _theme.textTheme.titleMedium
                  ?.copyWith(color: _theme.textSelectionTheme.cursorColor),
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  IconData(0xe780, fontFamily: 'MaterialIcons'),
                ),
              ),
              onChanged: (value) {
                _viewModel.updateEmail(value);
              },
            ),
          ),
        ],
      ),
    );
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
