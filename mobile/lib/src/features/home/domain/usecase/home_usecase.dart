import 'package:flutter_modular/flutter_modular.dart';

import '../repository/home_interface.dart';

class HomeUseCase {
  final repository = Modular.get<IHome>();
}
