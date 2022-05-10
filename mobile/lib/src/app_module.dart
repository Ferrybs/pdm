import 'package:basearch/src/features/auth/auth_module.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:basearch/src/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:basearch/src/features/onboarding/onboarding_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds =>
      [Bind((i) => AuthViewModel()), Bind((i) => HomeViewModel())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: OnboardingModule()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
