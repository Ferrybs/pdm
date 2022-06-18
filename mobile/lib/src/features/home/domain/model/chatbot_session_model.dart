import 'package:basearch/src/features/home/domain/model/chatbot_message_model.dart';

class ChatbotSessionModel {
  final String id;
  final List<ChatbotMessageModel> message;

  ChatbotSessionModel({required this.id, required this.message});

  factory ChatbotSessionModel.fromJson(Map<dynamic, dynamic> json) =>
      ChatbotSessionModel(
          id: json["id"],
          message: (json["chatbotMessagesDTO"] as List)
              .map((message) => ChatbotMessageModel.fromJson(message))
              .toList());
  Map<String, dynamic> toJson() =>
      {"id": id, "chatbotMessagesDTO": message.map((e) => e.toJson())};
}
