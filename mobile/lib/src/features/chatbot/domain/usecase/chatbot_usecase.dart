import 'package:basearch/src/features/chatbot/data/dto/response_dto.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_model.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_response_model.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

import '../../data/dto/person_dto.dart';
import '../model/chatbot_message_request_model.dart';
import '../model/client_model.dart';
import '../repository/chatbot_interface.dart';

class ChatbotUseCase {
  final _repository = Modular.get<IChatbot>();
  late ChatbotMessageResponseModel messageResponse;
  final _preference = Modular.get<PreferenceUsecase>();

  Future<ResponseDTO?> sendText(
      String text, String date, String sessionId) async {
    try {
      ChatbotMessageRequestModel? messageRequest = ChatbotMessageRequestModel(
          text: text, date: date, sessionId: sessionId);
      ChatbotMessageResponseModel? responseModel;
      responseModel = (await _repository.sendText(
          messageRequest, await _preference.getAccessToken() ?? ''));

      messageResponse = responseModel;

      ResponseDTO responseDTO = ResponseDTO(messageResponse.date,
          messageResponse.text, messageResponse.suggestions);
      return responseDTO;
    } catch (e) {
      return null;
    }
  }

  Future<List<ChatMessage>> getHistory(
      ChatUser user, ChatUser bot, String id) async {
    List<ChatMessage> chatmessages = [];
    try {
      var token = await _preference.getAccessToken();
      List<ChatbotMessageModel> messages =
          await _repository.getChatbotMessages(token ?? '', id);

      messages.sort(((a, b) {
        return b.date.compareTo(a.date);
      }));

      for (var element in messages) {
        ChatUser chatUser;
        if (element.type.id == "1") {
          chatUser = user;
        } else {
          chatUser = bot;
        }
        chatmessages.add(ChatMessage(
            user: chatUser, createdAt: element.date, text: element.text));
      }
    } catch (e) {
      return chatmessages;
    }
    return chatmessages;
  }

  Future<PersonDTO?> getClient() async {
    try {
      var token = await _preference.getAccessToken();
      ClientModel client = await _repository.getClient(token ?? '');
      PersonDTO person = PersonDTO(
          client.person.id, client.person.name, client.person.lastName);
      return person;
    } catch (e) {
      return null;
    }
  }
}
