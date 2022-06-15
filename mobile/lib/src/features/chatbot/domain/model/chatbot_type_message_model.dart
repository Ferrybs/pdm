class ChatbotTypeMEssageModel {
  ChatbotTypeMEssageModel({
    required this.id,
    required this.type,
  });
  String id;
  String type;

  factory ChatbotTypeMEssageModel.fromJson(Map<String, dynamic> json) =>
      ChatbotTypeMEssageModel(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {"id": id, "type": type};
}
