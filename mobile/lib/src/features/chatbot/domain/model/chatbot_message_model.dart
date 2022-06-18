import 'package:basearch/src/features/chatbot/domain/model/chatbot_type_message_model.dart';

class ChatbotMessageModel {
  ChatbotMessageModel(
      {required this.text, required this.date, required this.type});
  String text;
  DateTime date;
  ChatbotTypeMEssageModel type;

  factory ChatbotMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatbotMessageModel(
        text: json["text"],
        date: DateTime.parse(json["date"]),
        type: ChatbotTypeMEssageModel.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {"text": text, "date": date};
}
