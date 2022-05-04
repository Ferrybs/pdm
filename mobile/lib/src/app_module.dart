import 'package:basearch/src/features/auth/auth_module.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:basearch/src/features/onboarding/onboarding_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind(((i) => LoginViewModel()))];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: OnboardingModule()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
