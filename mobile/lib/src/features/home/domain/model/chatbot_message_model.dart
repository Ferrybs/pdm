class ChatbotMessageModel {
  final String message;
  final DateTime date;

  ChatbotMessageModel({required this.message, required this.date});

  factory ChatbotMessageModel.fromJson(Map<dynamic, dynamic> json) =>
      ChatbotMessageModel(
          message: json["message"], date: DateTime.parse(json["date"]));
  Map<String, dynamic> toJson() =>
      {"message": message, "date": date.toIso8601String()};
}
