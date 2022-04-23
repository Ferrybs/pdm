import 'package:basearch/src/features/auth/presentation/view/page/create_account.dart';
import 'package:basearch/src/features/auth/presentation/view/page/reset_password.dart';
import 'package:basearch/src/features/auth/presentation/view/page/success.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repository/login_repository.dart';
import 'domain/repository/login_interface.dart';
import 'domain/usecase/login_usecase.dart';
import 'presentation/view/page/login_page.dart';
import 'presentation/viewmodel/login_viewmodel.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => LoginViewModel()),
        Bind.factory((i) => LoginUseCase()),
        Bind.factory<ILogin>((i) => LoginRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage(), children: []),
        ChildRoute('/signup',
            child: (_, __) => const CreateAccount(), children: []),
        ChildRoute('/success',
            child: (_, __) => const SuccessLogin(), children: []),
        ChildRoute('/reset-password',
            child: (_, __) => const ResetPassword(), children: []),
      ];
}
