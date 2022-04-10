import 'package:basearch/components/hud/modal_progress_hud.dart';
import 'package:basearch/src/features/auth/presentation/view/widget/text_field_login.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);
  @override
  State<CreateAccount> createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
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
            _createAccount(),
            _commumSubtittle(),
            TextInputAuth(
                label: 'name'.i18n(),
                prefixIcon: const Icon(
                  IconData(0xf0071, fontFamily: 'MaterialIcons'),
                )),
            TextInputAuth(
              label: 'last-name'.i18n(),
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
                  child: Text('sign-up'.i18n().toUpperCase()),
                  onPressed: () {},
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
      ),
    );
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
