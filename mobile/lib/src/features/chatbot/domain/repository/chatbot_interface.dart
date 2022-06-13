import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_request_model.dart';

import '../model/chatbot_message_response_model.dart';
import '../model/client_model.dart';

abstract class IChatbot {
  //get messages
  //post message
  //envio: passar sessionId, text, date
  //retorno: lista de sugestões, type, date, text, sessionId
  //delete messages

  Future<ClientModel?> getClient(String token);
  Future<ChatbotMessageResponseModel?> sendText(
      ChatbotMessageRequestModel chatbotMessageRequestModel, String token);
}
