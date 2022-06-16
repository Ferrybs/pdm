import 'package:basearch/src/features/chatbot/data/repository/chatbot_repository.dart';
import 'package:basearch/src/features/chatbot/domain/repository/chatbot_interface.dart';
import 'package:basearch/src/features/chatbot/domain/usecase/chatbot_usecase.dart';
import 'package:basearch/src/features/chatbot/presentation/view/page/chatbot_page.dart';
import 'package:basearch/src/features/chatbot/presentation/viewmodel/chatbot_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatbotModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ChatbotViewModel()),
    Bind.factory((i) => ChatbotUseCase()),
    Bind.factory<IChatbot>((i) => ChatbotRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id',
        child: (_, args) => ChatbotPage(id: args.params['id'] ?? ''),
        children: []),
  ];
}
