import 'package:basearch/components/hud/modal_progress_hud.dart';
import 'package:basearch/components/button/rounded_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../viewmodel/login_viewmodel.dart';
import 'package:localization/localization.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login-scren'.i18n(),
      theme: ThemeData(
        primarySwatch: material_color(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xffF4FCD9),
              body: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: SizedBox(
                        width: 200,
                        height: 200,
                        child: SvgPicture.asset(
                            'lib/assets/images/v968-10-ps.svg')),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
                    child: Text(
                      'login'.i18n(),
                      style: const TextStyle(
                          color: Color(0xff534340),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'signin'.i18n(),
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'E-mail',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Color(0xff534340)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: (const TextStyle(
                                color: Color(0xffC5D8A4),
                                fontWeight: FontWeight.w400)),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color(0xffC5D8A4),
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xff534340),
                              filled: true,
                              prefixIcon: Icon(IconData(0xe780,
                                  fontFamily: 'MaterialIcons')),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffC5D8A4), width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'password'.i18n(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Color(0xff534340)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: (const TextStyle(
                              color: Color(0xffC5D8A4),
                              fontWeight: FontWeight.w400)),
                          obscureText: true,
                          cursorColor: Color(0xffC5D8A4),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff534340),
                            filled: true,
                            prefixIcon: Icon(
                                IconData(0xeb71, fontFamily: 'MaterialIcons')),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffC5D8A4), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: RoundedButton(
                        btnText: 'login'.i18n().toUpperCase(),
                        color: Color(0xff534340),
                        onPressed: () {},
                        textColor: Color(0xffC5D8A4),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      child: Text(
                        'forgot-pass'.i18n(),
                        style: const TextStyle(color: Color(0xff534340)),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'no-account'.i18n(),
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          Modular.to.navigate('/signup');
                        },
                        child: Text('sign-up'.i18n(),
                            style: const TextStyle(
                              color: Color(0xff534340),
                            )),
                      )
                    ],
                  )
                ]),
              ),
            ),
          )),
    );
  }

  MaterialColor material_color() {
    return const MaterialColor(
      0xffc5d8a4, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
      <int, Color>{
        50: Color(0xffcbdcad), //10%
        100: Color(0xffd1e0b6), //20%
        200: Color(0xffd6e4bf), //30%
        300: Color(0xffdce8c8), //40%
        400: Color(0xffe2ecd2), //50%
        500: Color(0xffe8efdb), //60%
        600: Color(0xffeef3e4), //70%
        700: Color(0xfff3f7ed), //80%
        800: Color(0xfff9fbf6), //90%
        900: Color(0xffffffff), //100%
      },
    );
  }
}
