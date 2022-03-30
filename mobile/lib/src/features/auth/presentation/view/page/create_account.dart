import 'package:basearch/components/modal_progress_hud/modal_progress_hud.dart';
import 'package:basearch/components/rounded_btn/rounded_btn.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            backgroundColor: Color(0xff251F34),
          ),
          backgroundColor: Color(0xff251F34),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  'create-account'.i18n(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'fill-input'.i18n(),
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'name'.i18n(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon: Icon(
                            IconData(0xf0071, fontFamily: 'MaterialIcons')),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'last-name'.i18n(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon: Icon(
                            IconData(0xf0071, fontFamily: 'MaterialIcons')),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon:
                            Icon(IconData(0xe780, fontFamily: 'MaterialIcons')),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'password'.i18n(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      obscureText: true,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon:
                            Icon(IconData(0xeb71, fontFamily: 'MaterialIcons')),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                    btnText: 'sign-up'.i18n().toUpperCase(),
                    color: Color(0xff14DAE2),
                    onPressed: () {},
                    textColor: Color(0xffC5D8A4),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'have-account'.i18n(),
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Modular.to.navigate('/');
                    },
                    child: Text('sign-in'.i18n(),
                        style: const TextStyle(
                          color: Color(0xff14DAE2),
                        )),
                  )
                ],
              ),
            ],
          )),
        ));
  }
}

Widget _goBackButton(BuildContext context) {
  return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey[350]),
      onPressed: () {
        Modular.to.navigate('/');
      });
}
