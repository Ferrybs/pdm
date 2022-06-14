import 'package:basearch/src/features/chatbot/presentation/view/widget/chatbot_app_bar.dart';
import 'package:basearch/src/features/chatbot/presentation/viewmodel/chatbot_viewmodel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import '../widget/dialog_container.dart';

class ChatbotPage extends StatefulWidget {
  final String id;
  const ChatbotPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPage();
}

class _ChatbotPage extends State<ChatbotPage> {
  late ThemeData _theme;
  final _viewModel = Modular.get<ChatbotViewModel>();

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      appBar: ChatbotAppBar(),
      body: Observer(
          builder: (_) => FutureBuilder(
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError || _viewModel.errorLoad != null) {
                    return Container(
                      color: _theme.colorScheme.background,
                      child: DialogContainer(
                        message: _viewModel.errorLoad!,
                        buttonText: "try-again".i18n(),
                        onClick: () {
                          _viewModel.navigateToLogin();
                        },
                      ),
                    );
                  } else {
                    return DashChat(
                      currentUser: _viewModel.chatUser,
                      onSend: (ChatMessage m) async {
                        await _viewModel.onSend(m);
                      },
                      quickReplyOptions: QuickReplyOptions(
                        onTapQuickReply: (QuickReply r) {
                          final ChatMessage resp = ChatMessage(
                            user: _viewModel.chatUser,
                            text: r.value ?? r.title,
                            createdAt: DateTime.now(),
                          );
                          _viewModel.onSend(resp);
                        },
                        quickReplyTextStyle: _theme.textTheme.titleSmall,
                        quickReplyStyle: BoxDecoration(
                            border: Border.all(
                                color: _theme.colorScheme.tertiary, width: 1),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      messages: _viewModel.messageList,
                      inputOptions: InputOptions(
                          inputTextStyle: _theme.textTheme.bodyMedium),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
              future: _viewModel.getData())),
    );
  }

  _createTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: _theme.textTheme.headlineMedium,
      ),
    );
  }

  _createAction() {
    return IconButton(
      icon: const Icon(Icons.home),
      onPressed: () => {_viewModel.navigateToHome()},
    );
  }
}
