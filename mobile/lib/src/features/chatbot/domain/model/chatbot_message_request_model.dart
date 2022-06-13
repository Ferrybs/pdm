class ChatbotMessageRequestModel {
  ChatbotMessageRequestModel(
      {required this.sessionId, required this.text, required this.date});
  late final String sessionId;
  late final String text;
  late final String date;

  factory ChatbotMessageRequestModel.fromJson(Map<String, dynamic> json) =>
      ChatbotMessageRequestModel(
          sessionId: json["sessionId"], text: json["text"], date: json["date"]);

  Map<String, dynamic> toJson() =>
      {"sessionId": sessionId, "text": text, "date": date};
}
