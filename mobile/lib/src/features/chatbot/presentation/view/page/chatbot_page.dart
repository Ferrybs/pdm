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
  late Future<void> result;
  final _viewModel = Modular.get<ChatbotViewModel>();
  List<ChatMessage> messages = [];
  @override
  void initState() {
    super.initState();
    result = _viewModel.getData(widget.id);
  }

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
                    return Observer(builder: (_) {
                      return DashChat(
                        messageOptions: MessageOptions(
                            currentUserContainerColor:
                                _theme.colorScheme.secondary,
                            containerColor:
                                _theme.colorScheme.primaryContainer),
                        currentUser: _viewModel.chatUser!,
                        onSend: (ChatMessage m) async {
                          _viewModel.insertMessage(m);
                          _updateMessages();
                          await _viewModel.onSend(m);
                          _updateMessages();
                        },
                        quickReplyOptions: QuickReplyOptions(
                          onTapQuickReply: (QuickReply r) {
                            final ChatMessage resp = ChatMessage(
                              user: _viewModel.chatUser!,
                              text: r.value ?? r.title,
                              createdAt: DateTime.now().toUtc(),
                            );
                            _viewModel.insertMessage(resp);
                            _updateMessages();
                            _viewModel.onSend(resp);
                            _updateMessages();
                          },
                          quickReplyTextStyle: _theme.textTheme.titleSmall,
                          quickReplyStyle: BoxDecoration(
                              border: Border.all(
                                  color: _theme.colorScheme.tertiary, width: 1),
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        messages: messages.isEmpty
                            ? _viewModel.messageList
                            : messages,
                        inputOptions: InputOptions(
                            inputTextStyle: _theme.textTheme.bodyMedium),
                      );
                    });
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
              future: result)),
    );
  }

  _updateMessages() {
    setState(() {
      messages = _viewModel.messageList;
    });
  }
}
