import 'package:basearch/src/features/auth/auth_module.dart';
import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:basearch/src/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:basearch/src/features/onboarding/onboarding_module.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_config/flutter_config.dart';

import 'features/home/home_module.dart';
import 'features/map/map_module.dart';
import 'features/map/presentation/viewmodel/map_viewmodel.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthViewModel()),
        Bind((i) => HomeViewModel()),
        Bind((i) => MapViewModel()),
        Bind((i) async {
          await FlutterConfig.loadEnvVariables();
        }),
        Bind(((i) => EncryptedSharedPreferences()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: OnboardingModule()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/map', module: MapModule()),
      ];
}
