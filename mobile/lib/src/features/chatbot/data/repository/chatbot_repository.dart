import 'package:basearch/src/features/chatbot/data/repository/repository_base.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_request_model.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_response_model.dart';
import 'package:dio/dio.dart';

import '../../domain/model/client_model.dart';
import '../../domain/repository/chatbot_interface.dart';

class ChatbotRepository extends ChatbotRepositoryBase implements IChatbot {
  @override
  Future<ChatbotMessageResponseModel?> sendText(
      ChatbotMessageRequestModel chatbotMessageRequestModel,
      String token) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.post("/chatbot/send/text",
          data: chatbotMessageRequestModel.toJson(),
          options: Options(headers: {"Authorization": "Bearer " + token}));
      if (response.statusCode == 200) {
        var messageResponse = ChatbotMessageResponseModel.fromJson(
            response.data['chatbotMessageDTO']);
        return messageResponse;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ClientModel?> getClient(String token) async {
    try {
      Response response;
      var dio = Dio(options);
      response = await dio.get("/client/",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      if (response.statusCode == 200) {
        var messageResponse = ClientModel.fromJson(response.data['clientDTO']);
        return messageResponse;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
