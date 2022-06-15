import 'package:basearch/src/features/home/presentation/view/widget/chatbot_card.dart';
import 'package:basearch/src/features/home/presentation/view/widget/dialog_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

import '../../viewmodel/home_viewmodel.dart';

class HomeChatPage extends StatefulWidget {
  const HomeChatPage({Key? key}) : super(key: key);
  @override
  State<HomeChatPage> createState() => _HomeChatPage();
}

class _HomeChatPage extends State<HomeChatPage> {
  late ThemeData _theme;
  final _viewModel = Modular.get<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Observer(builder: (context) {
      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || _viewModel.error != null) {
              return Container(
                color: _theme.colorScheme.background,
                child: DialogContainer(
                  message: _viewModel.error ?? "session-error-tittle".i18n(),
                  buttonText: "try-again".i18n(),
                  onClick: () {
                    _viewModel.navigateToLogin();
                  },
                ),
              );
            } else {
              return SafeArea(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                    child: _createTitle(_viewModel.getChathomeTittle()),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _chatList(),
                    ),
                  ),
                  _addchatButton()
                ],
              ));
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: _viewModel.getChatData(),
      );
    });
  }

  Padding _addchatButton() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: (() {
              _viewModel.navigateToChatbot(_viewModel.getNewChatbotSessionID());
            }),
            child: const Icon(Icons.add),
          ),
        ));
  }

  ListView _chatList() {
    return ListView.builder(
        itemCount: _viewModel.chatbotSessions.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return ChatbotCard(
              onTap: _viewModel.navigateToChatbot,
              onDelete: _viewModel.onDeleteChatSession,
              id: _viewModel.chatbotSessions[index].id,
              index: index,
              messageDTO: _viewModel
                  .chatbotSessions[_viewModel.chatbotSessions.length - 1]
                  .chatbotMessageDTO);
        }));
  }

  _createTitle(String tittle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        tittle,
        style: _theme.textTheme.headlineMedium,
      ),
    );
  }
}
