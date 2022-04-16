import 'package:basearch/components/hud/modal_progress_hud.dart';
import 'package:basearch/src/features/auth/presentation/view/widget/text_field_login.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  State<PasswordRecovery> createState() => _CreateAccount();
}

class _CreateAccount extends State<PasswordRecovery> {
  final _viewModel = Modular.get<LoginViewModel>();
  bool showSpinner = false;
  late ThemeData _theme;
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
              label: 'email'.i18n(),
              prefixIcon: const Icon(
                IconData(0xf0071, fontFamily: 'MaterialIcons'),
              ),
            ),
            TextInputAuth(
              label: 'password'.i18n(),
              obscureText: true,
              prefixIcon: const Icon(
                IconData(0xeb71, fontFamily: 'MaterialIcons'),
              ),
            ),
            TextInputAuth(
              label: 'confirm-password'.i18n(),
              obscureText: true,
              prefixIcon: const Icon(
                IconData(0xeb71, fontFamily: 'MaterialIcons'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  child: Text('recovery'.i18n().toUpperCase()),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        )),
      ),
    );
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
          'recovery'.i18n(),
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
