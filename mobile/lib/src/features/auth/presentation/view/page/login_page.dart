import 'package:basearch/components/modal_progress_hud/modal_progress_hud.dart';
import 'package:basearch/components/rounded_btn/rounded_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../viewmodel/login_viewmodel.dart';

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
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xff251F34),
              body: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: SizedBox(
                        width: 175,
                        height: 175,
                        child:
                            SvgPicture.asset('lib/assets/images/flutter.svg')),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Please sign in to continue.',
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
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: (const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.white,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color(0xfff3B324E),
                              filled: true,
                              prefixIcon: Icon(IconData(0xe780,
                                  fontFamily: 'MaterialIcons')),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff14DAE2), width: 2.0),
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
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: (const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                          obscureText: true,
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xfff3B324E),
                            filled: true,
                            prefixIcon: Icon(
                                IconData(0xeb71, fontFamily: 'MaterialIcons')),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff14DAE2), width: 2.0),
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
                        btnText: 'LOGIN',
                        color: Color(0xff14DAE2),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color(0xff14DAE2)),
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
                        'Dont have an account?',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Sign up',
                            style: TextStyle(
                              color: Color(0xff14DAE2),
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

  todo() {}
}
