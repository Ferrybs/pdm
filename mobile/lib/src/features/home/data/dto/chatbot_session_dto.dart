import 'package:basearch/src/features/home/data/dto/chatbot_message_dto.dart';

class ChatbotSessionDTO {
  String id;
  ChatbotMessageDTO chatbotMessageDTO;
  ChatbotSessionDTO({required this.id, required this.chatbotMessageDTO});
}
