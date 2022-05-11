import 'package:basearch/src/features/auth/presentation/view/page/create_account.dart';
import 'package:basearch/src/features/auth/presentation/view/page/reset_password.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repository/auth_repository.dart';
import 'domain/repository/auth_interface.dart';
import 'domain/usecase/auth_usecase.dart';
import 'presentation/view/page/login_page.dart';
import 'presentation/viewmodel/auth_viewmodel.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => AuthModule()),
        Bind.factory((i) => AuthUseCase()),
        Bind.factory<IAuth>((i) => AuthRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage(), children: []),
        ChildRoute('/signup',
            child: (_, __) => const CreateAccount(), children: []),
        ChildRoute('/reset-password',
            child: (_, __) => const ResetPassword(), children: []),
      ];
}
