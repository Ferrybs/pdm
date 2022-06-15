import 'package:flutter_modular/flutter_modular.dart';

import 'data/repository/home_repository.dart';
import 'domain/repository/home_interface.dart';
import 'domain/usecase/home_usecase.dart';
import 'presentation/view/page/home_page.dart';
import 'presentation/viewmodel/home_viewmodel.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeViewModel()),
    Bind.factory((i) => HomeUseCase()),
    Bind.factory<IHome>((i) => HomeRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id',
        child: (_, args) => HomePage(
              idx: args.params['id'].toString().isNotEmpty
                  ? int.parse(args.params['id'])
                  : 1,
            ),
        children: []),
  ];
}
