import 'package:basearch/src/features/modelo/domain/usecase/modelo_usecase.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';

import '../../data/dto/person_dto.dart';
import '../../data/dto/response_dto.dart';
import '../../domain/usecase/chatbot_usecase.dart';
import '../view/page/data.dart';

part 'chatbot_viewmodel.g.dart';

class ChatbotViewModel = _ChatbotViewModel with _$ChatbotViewModel;

abstract class _ChatbotViewModel with Store {
  final _usecase = Modular.get<ChatbotUseCase>();

  @observable
  late ChatUser chatUser = ChatUser(id: "1");

  @observable
  String sessionId = "";

  @observable
  ChatUser botUser = ChatUser(id: "0", firstName: "Plantie");

  @observable
  String? errorLoad;

  @observable
  List<ChatMessage> messageList = [];

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

  onSend(ChatMessage m) async {
    insertMessage(m);
    await _usecase.sendText(m.text, m.createdAt.toString(), sessionId);
    ResponseDTO? response = _usecase.responseDTO;

    if (response != null) {
      insertMessage(ChatMessage(
          user: botUser,
          createdAt: DateTime.parse(response.date!),
          quickReplies: _createSuggestionsList(response.suggestions!)));
    }
  }

  _createSuggestionsList(List<String> suggestionsList) {
    return suggestionsList
        .map((suggestion) => QuickReply(title: suggestion))
        .toList();
  }

  getData() async {
    PersonDTO? personDTO = await _usecase.getClient();
    if (personDTO != null) {
      updateChatUser(ChatUser(
          id: personDTO.id!,
          firstName: personDTO.name!,
          lastName: personDTO.lastName!));
      updateSessionId("6776u9dg");
    } else {
      updateErrorLoad("error-get-client".i18n());
    }
  }

  String getChatbotTitle() {
    return "chatbot-title".i18n();
  }

  void navigateToLogin() {
    Modular.to.navigate("/auth/");
  }

  Future<String?> setSessionId() async {
    // var uuid = Uuid();
    // var sessionId = uuid.v1();
    sessionId = "6776u9dg";
    return sessionId;
  }

  Future<String> setDate() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
    return formattedDate;
  }

  Future<String?> sendText(String m) async {
    String date = await setDate();
    String? sessionId = await setSessionId();
    String? response = await _usecase.sendText(m, date, sessionId!);

    if (response == null) {
      return _usecase.messageResponse.text;
    }

    return response;
  }

  void navigateToHome() {
    Modular.to.navigate('/home/');
  }

  // List<ChatMessage> get messages {
  //   List<ChatMessage> messages = quickReplies;
  //   return messages;
  // }
}
