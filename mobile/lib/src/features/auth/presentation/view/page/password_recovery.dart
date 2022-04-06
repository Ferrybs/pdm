import 'package:basearch/components/hud/modal_progress_hud.dart';
import 'package:basearch/src/Theme/theme.dart';
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
  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Builder(
                builder: (context) => Text(
                  'create-account'.i18n(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Builder(
                builder: (context) => Text(
                  'fill-input'.i18n(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('name'.i18n(),
                      style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 10),
                  Builder(
                      builder: (context) => TextField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                IconData(0xf0071, fontFamily: 'MaterialIcons'),
                              ),
                            ),
                            onChanged: (value) {},
                          )),
                  const SizedBox(height: 10),
                  Text(
                    'last-name'.i18n(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 10),
                  Builder(
                      builder: (context) => TextField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                IconData(0xf0071, fontFamily: 'MaterialIcons'),
                              ),
                            ),
                            onChanged: (value) {},
                          )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('E-mail', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  Builder(
                      builder: (context) => TextField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                IconData(0xe780, fontFamily: 'MaterialIcons'),
                              ),
                            ),
                            onChanged: (value) {},
                          )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Builder(
                    builder: (context) => Text(
                      'password'.i18n(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Builder(
                      builder: (context) => TextField(
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .cursorColor),
                            obscureText: true,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                IconData(0xeb71, fontFamily: 'MaterialIcons'),
                              ),
                            ),
                            onChanged: (value) {},
                          )),
                ],
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
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: () => Modular.to.navigate('/'),
                  child: Text('sign-in'.i18n()),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}

Widget _goBackButton(BuildContext context) {
  return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey[350]),
      onPressed: () {
        Modular.to.navigate('/');
      });
}
