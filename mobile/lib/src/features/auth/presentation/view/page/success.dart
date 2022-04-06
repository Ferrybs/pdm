import 'dart:math';

import 'package:basearch/src/Theme/theme.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessLogin extends StatefulWidget {
  const SuccessLogin({Key? key}) : super(key: key);

  @override
  State<SuccessLogin> createState() => _SuccessLogin();
}

class _SuccessLogin extends State<SuccessLogin> {
  late ConfettiController _controllerBottomCenter;
  final controller = LoginViewModel();

  @override
  void initState() {
    ConfettiController(duration: const Duration(seconds: 2));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _controllerBottomCenter.play());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " ",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(
              builder: (context) => Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerBottomCenter,
                  blastDirection: pi,
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
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Builder(
                builder: (context) => Text(
                  controller.clientName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Builder(
                builder: (context) => Text(
                  'Congratulations, ${controller.clientName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You have logged in.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(
                height: 200,
                width: 200,
                child: SvgPicture.asset('lib/assets/images/success.svg')),
          ],
        ),
      ),
    );
  }
}
