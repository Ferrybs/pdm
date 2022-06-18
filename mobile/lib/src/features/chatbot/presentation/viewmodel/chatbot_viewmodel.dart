import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';

import '../../data/dto/person_dto.dart';
import '../../domain/usecase/chatbot_usecase.dart';

part 'chatbot_viewmodel.g.dart';

class ChatbotViewModel = _ChatbotViewModel with _$ChatbotViewModel;

abstract class _ChatbotViewModel with Store {
  final _usecase = Modular.get<ChatbotUseCase>();

  @observable
  ChatUser? chatUser;

  @observable
  String? sessionId;

  @observable
  ChatUser botUser = ChatUser(id: "0", firstName: "Plantie");

  @observable
  String? errorLoad;

  @observable
  ObservableList<ChatMessage> messageList = ObservableList<ChatMessage>();

  @action
  updateChatUser(ChatUser value) {
    chatUser = value;
  }

  @action
  updateErrorLoad(String? value) {
    errorLoad = value;
  }

  @action
  updateSessionId(String value) {
    sessionId = value;
  }

  @action
  insertMessage(ChatMessage m) {
    messageList.insert(0, m);
  }

  @action
  insertMessageList(List<ChatMessage> m) {
    messageList = m.asObservable();
  }

  onSend(ChatMessage m) async {
    final response = await _usecase.sendText(
        m.text, m.createdAt.toUtc().toIso8601String(), sessionId ?? '');
    if (response != null) {
      insertMessage(ChatMessage(
          user: botUser,
          text: response.text!,
          createdAt: DateTime.parse(response.date!),
          quickReplies: _createSuggestionsList(response.suggestions!)));
    }
  }

  _createSuggestionsList(List<String> suggestionsList) {
    return suggestionsList
        .map((suggestion) => QuickReply(title: suggestion))
        .toList();
  }

  Future<void> getData(String id) async {
    PersonDTO? personDTO = await _usecase.getClient();
    if (personDTO != null) {
      ChatUser user = ChatUser(
          id: personDTO.id!,
          firstName: personDTO.name!,
          lastName: personDTO.lastName!);
      updateChatUser(user);
      updateSessionId(id);
      insertMessageList(await _usecase.getHistory(user, botUser, id));
    } else {
      updateErrorLoad("session-error-tittle".i18n());
    }
    return;
  }

  String getChatbotTitle() {
    return "chatbot-title".i18n();
  }

  void navigateToLogin() {
    Modular.to.navigate("/auth/");
  }

  void navigateToHome() {
    Modular.to.navigate('/home/2');
  }
}
