import 'package:basearch/src/features/auth/auth_module.dart';
import 'package:basearch/src/features/onboarding/onboarding_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_config/flutter_config.dart';

import 'features/home/home_module.dart';
import 'features/map/map_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) async {
          await FlutterConfig.loadEnvVariables();
        })
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: OnboardingModule()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/map', module: MapModule()),
      ];
}
