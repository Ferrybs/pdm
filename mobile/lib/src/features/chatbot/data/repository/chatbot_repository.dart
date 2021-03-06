import 'package:basearch/src/features/chatbot/data/repository/repository_base.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_model.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_request_model.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_response_model.dart';
import 'package:dio/dio.dart';

import '../../domain/model/client_model.dart';
import '../../domain/repository/chatbot_interface.dart';

class ChatbotRepository extends ChatbotRepositoryBase implements IChatbot {
  @override
  Future<ChatbotMessageResponseModel> sendText(
      ChatbotMessageRequestModel chatbotMessageRequestModel,
      String token) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.post("/chatbot/send/text",
          data: chatbotMessageRequestModel.toJson(),
          options: Options(headers: {"Authorization": "Bearer " + token}));
      var messageResponse = ChatbotMessageResponseModel.fromJson(
          response.data['chatbotMessageDTO']);
      return messageResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClientModel> getClient(String token) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.get("/client/",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return ClientModel.fromJson(response.data['clientDTO']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatbotMessageModel>> getChatbotMessages(
      String token, String id) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.get("/chatbot/" + id,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return (response.data['chatbotMessagesDTO'] as List)
          .map((message) => ChatbotMessageModel.fromJson(message))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
