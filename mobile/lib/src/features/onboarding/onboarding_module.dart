import 'package:basearch/src/features/auth/auth_module.dart';
import 'package:basearch/src/features/onboarding/presentation/page/onboarding_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OnboardingModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const OnBoardingPage(), children: []),
      ];
}
