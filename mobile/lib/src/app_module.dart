import 'package:basearch/src/features/auth/auth_module.dart';
import 'package:basearch/src/features/device/device_module.dart';
import 'package:basearch/src/features/onboarding/onboarding_module.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_config/flutter_config.dart';

import 'features/chatbot/chatbot_module.dart';
import 'features/home/home_module.dart';
import 'features/map/map_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) async {
          await FlutterConfig.loadEnvVariables();
          return null;
        }),
        Bind(((i) => PreferenceUsecase()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: OnboardingModule()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/map', module: MapModule()),
        ModuleRoute('/device', module: DeviceModule()),
        ModuleRoute('/chatbot', module: ChatbotModule())
      ];
}
