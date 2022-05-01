import 'dart:math';

import 'package:basearch/src/app_module.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessLogin extends StatefulWidget {
  const SuccessLogin({Key? key}) : super(key: key);

  @override
  State<SuccessLogin> createState() => _SuccessLogin();
}

class _SuccessLogin extends State<SuccessLogin> {
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    ConfettiController(duration: const Duration(seconds: 2));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _controllerBottomCenter.play());
    super.initState();
  }

  late ThemeData _theme;
  final _viewModel = Modular.get<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _confettiConfig(),
          _commumText('Congratulations, ${_viewModel.client?.person?.name}'),
          _commumText('You have logged in.'),
          SizedBox(
              height: 200,
              width: 200,
              child: SvgPicture.asset('lib/assets/images/success.svg')),
        ],
      ),
    );
  }

  Padding _commumText(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Builder(
        builder: (context) => Text(
          text,
          style: _theme.textTheme.titleLarge,
        ),
      ),
    );
  }

  Builder _confettiConfig() {
    return Builder(
      builder: (context) => Align(
        alignment: Alignment.topCenter,
        child: ConfettiWidget(
          confettiController: _controllerBottomCenter,
          blastDirection: pi / 2,
          maxBlastForce: 3, // set a lower max blast force
          minBlastForce: 2,
          emissionFrequency: 0.3,
          minimumSize: const Size(10,
              10), // set the minimum potential size for the confetti (width, height)
          maximumSize: const Size(20,
              20), // set the maximum potential size for the confetti (width, height)
          numberOfParticles: 1,
          gravity: 1,
        ),
      ),
    );
  }
}
