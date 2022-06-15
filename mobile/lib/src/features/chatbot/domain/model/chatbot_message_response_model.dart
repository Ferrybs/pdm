class ChatbotMessageResponseModel {
  ChatbotMessageResponseModel(
      {required this.text, required this.date, required this.suggestions});
  String text;
  String date;
  List<String> suggestions;

  factory ChatbotMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatbotMessageResponseModel(
          text: json["text"],
          date: json["date"],
          suggestions: (json["suggestions"] as List)
              .map((suggestion) => suggestion.toString())
              .toList());

  Map<String, dynamic> toJson() =>
      {"text": text, "date": date, "suggestions": suggestions};
}
