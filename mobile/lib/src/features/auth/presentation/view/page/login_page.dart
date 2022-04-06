import 'package:basearch/components/hud/modal_progress_hud.dart';
import 'package:basearch/src/Theme/theme.dart';
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
  final controller = LoginViewModel();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login-scren'.i18n(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      home: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child:
                          SvgPicture.asset('lib/assets/images/v968-10-ps.svg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
                    child: Builder(
                      builder: (context) => Text(
                        'login'.i18n(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Builder(
                      builder: (context) => Text(
                        'signin'.i18n(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Builder(
                          builder: (context) => Text(
                            'E-mail',
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
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                IconData(0xe780, fontFamily: 'MaterialIcons'),
                              ),
                            ),
                            onChanged: (value) {
                              controller.updateEmail(value);
                            },
                          ),
                        ),
                      ],
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
                            onChanged: (value) {
                              controller.updatePassword(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        child: Text('login'.i18n().toUpperCase()),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          final client = await controller.login();
                          print(client);
                          if (client != null) {
                            setState(() {
                              showSpinner = false;
                            });
                            Modular.to.navigate('/success');
                          }
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      child: Text('forgot-pass'.i18n()),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) => Text(
                          'no-account'.i18n(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Modular.to.navigate('/signup'),
                        child: Text('sign-up'.i18n()),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          )),
    );
  }
}
